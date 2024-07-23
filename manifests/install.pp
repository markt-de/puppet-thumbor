# @summary Install packages and dependencies for Thumbor
# @api private
class thumbor::install {
  require(['thumbor::python', 'thumbor::user', 'thumbor::upgrade'])

  if $thumbor::manage_epel and $facts['os']['family'] == 'RedHat' {
    require epel
  }

  if $thumbor::venv_path {
    # Install thumbor in a virtualenv.
    python::pyvenv { $thumbor::venv_path:
      ensure  => $thumbor::ensure,
      version => 'system',
      owner   => $thumbor::user,
      group   => $thumbor::group,
      require => Class['python'],
      before  => [Python::Pip[$thumbor::package_name], Python::Pip[[$thumbor::plugins]]],
    }
  }
  stdlib::ensure_packages($thumbor::additional_packages)

  $venv = $thumbor::venv_path ? {
    undef   => 'system',
    default => $thumbor::venv_path,
  }

  python::pip { $thumbor::package_name:
    ensure       => $thumbor::version,
    virtualenv   => $venv,
    pip_provider => $thumbor::pip_provider,
    proxy        => $thumbor::pip_proxyserver,
    require      => Package[$thumbor::additional_packages],
    notify       => Class['thumbor::service'],
  }

  python::pip { [$thumbor::plugins]:
    ensure       => $thumbor::package_ensure,
    virtualenv   => $venv,
    pip_provider => $thumbor::pip_provider,
    proxy        => $thumbor::pip_proxyserver,
    require      => Package[$thumbor::additional_packages],
    notify       => Class['thumbor::service'],
  }
}
