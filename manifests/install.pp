# @summary Install packages and dependencies for Thumbor
# @api private
class thumbor::install {
  anchor { 'thumbor::install::begin': }

  if $thumbor::manage_group {
    group { $thumbor::group:
      ensure  => present,
      system  => true,
      require => Anchor['thumbor::install::begin'],
      before  => Python::Virtualenv[$thumbor::virtualenv_path],
    }
  }

  if $thumbor::manage_user {
    $homepath = $thumbor::virtualenv_path ? {
      undef   => '/home/thumbor/',
      default => "${thumbor::virtualenv_path}/",
    }

    user { $thumbor::user:
      system  => true,
      gid     => $thumbor::group,
      home    => $homepath,
      require => Group[$thumbor::group],
      before  => Python::Virtualenv[$thumbor::virtualenv_path],
    }
  }

  if $thumbor::manage_python {
    class { 'python' :
      version    => 'system',
      pip        => 'present',
      dev        => 'present',
      virtualenv => 'present',
      require    => Anchor['thumbor::install::begin'],
    }
  }

  if $thumbor::virtualenv_path {
    # Install thumbor in a virtualenv.
    python::virtualenv { $thumbor::virtualenv_path:
      ensure  => $thumbor::ensure,
      version => 'system',
      proxy   => $thumbor::pip_proxyserver,
      owner   => $thumbor::user,
      group   => $thumbor::group,
      require => [ Class['python'] ],
      before  => Anchor['thumbor::install::virtualenv'],
    }
  }
  anchor { 'thumbor::install::virtualenv':
    require => Anchor['thumbor::install::begin'],
    before  => Anchor['thumbor::install::end'],
  }

  ensure_packages($thumbor::additional_packages)

  $venv = $thumbor::virtualenv_path ? {
    undef   => 'system',
    default => $thumbor::virtualenv_path,
  }

  python::pip { $thumbor::package_name:
    ensure     => $thumbor::package_ensure,
    virtualenv => $venv,
    proxy      => $thumbor::pip_proxyserver,
    require    => [ Package[$thumbor::additional_packages], Anchor['thumbor::install::virtualenv'] ],
    before     => Anchor['thumbor::install::end'],
  }

  python::pip { 'opencv-python':
    ensure     => $thumbor::package_ensure,
    virtualenv => $venv,
    proxy      => $thumbor::pip_proxyserver,
    require    => [ Package[$thumbor::additional_packages], Anchor['thumbor::install::virtualenv'] ],
    before     => Anchor['thumbor::install::end'],
  }

  python::pip { [ $thumbor::extentions ]:
    ensure     => $thumbor::package_ensure,
    virtualenv => $venv,
    proxy      => $thumbor::pip_proxyserver,
    require    => Anchor['thumbor::install::virtualenv'],
    before     => Anchor['thumbor::install::end'],
  }

  anchor { 'thumbor::install::end': }
}
