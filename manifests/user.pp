# @summary Setup users and groups for Thumbor
# @api private
class thumbor::user {
  if $thumbor::manage_group {
    group { $thumbor::group:
      ensure => $thumbor::ensure,
      system => true,
    }
  }

  if $thumbor::manage_user {
    $homepath = $thumbor::venv_path ? {
      undef   => '/home/thumbor/',
      default => "${thumbor::venv_path}/",
    }

    user { $thumbor::user:
      ensure  => $thumbor::ensure,
      system  => true,
      gid     => $thumbor::group,
      home    => $homepath,
      require => Group[$thumbor::group],
      before  => Python::Pyvenv[$thumbor::venv_path],
    }
  }
}
