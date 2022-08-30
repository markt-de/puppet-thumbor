# @summary Install packages and dependencies for Thumbor
# @api private
class thumbor::install {
  anchor { 'thumbor::install::begin': }

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
      before  => Anchor['thumbor::install::virtualenv'],
    }
  }
  anchor { 'thumbor::install::virtualenv':
    require => Anchor['thumbor::install::begin'],
    before  => Anchor['thumbor::install::end'],
  }

  ensure_packages($thumbor::additional_packages)

  $venv = $thumbor::venv_path ? {
    undef   => 'system',
    default => $thumbor::venv_path,
  }

  python::pip { $thumbor::package_name:
    ensure       => $thumbor::version,
    virtualenv   => $venv,
    pip_provider => $thumbor::pip_provider,
    proxy        => $thumbor::pip_proxyserver,
    require      => [
      Package[$thumbor::additional_packages],
      Anchor['thumbor::install::virtualenv'],
    ],
    before       => Anchor['thumbor::install::end'],
    notify       => Class['thumbor::service'],
  }

  python::pip { [$thumbor::plugins]:
    ensure       => $thumbor::package_ensure,
    virtualenv   => $venv,
    pip_provider => $thumbor::pip_provider,
    proxy        => $thumbor::pip_proxyserver,
    require      => [
      Package[$thumbor::additional_packages],
      Anchor['thumbor::install::virtualenv'],
    ],
    before       => Anchor['thumbor::install::end'],
    notify       => Class['thumbor::service'],
  }

  anchor { 'thumbor::install::end': }
}
