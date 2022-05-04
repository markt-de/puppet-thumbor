# @summary Upgrade Thumbor's Python venv
# @api private
class thumbor::upgrade {
  # Only perform upgrades when using Python venv.
  if $thumbor::update_enabled and $thumbor::venv_path {
    $upgrade_statefile = "${thumbor::config_dir}/${thumbor::statefile}"

    # Get the Python version that should be used for Thumbor's venv.
    if ($thumbor::python_config and 'version' in $thumbor::python_config) {
      $_python_version = regsubst($thumbor::python_config['version'], '[^0-9]', '', 'G')
    } elsif ('python3_release' in $facts) {
      $_python_version = regsubst($facts['python3_release'], '[^0-9]', '', 'G')
    }

    # Fallback if the Python version is still unknown.
    if (!defined('$_python_version') or empty($_python_version)) {
      $python_version = '3'
    } else {
      $python_version = $_python_version
    }

    # Try to guess the name of the Python binary.
    $python_bin = "python${python_version}"

    # Check if upgrade is necessary by comparing version information.
    $upgrade_check = join([
      "test -f ${upgrade_statefile}",
      "&& ! grep '^${thumbor::version}/${python_version}$' ${upgrade_statefile}",
    ], ' ')
    $upgrade_cmd = "${python_bin} -m venv --upgrade ${thumbor::venv_path}"

    exec { 'upgrade venv':
      command => $upgrade_cmd,
      onlyif  => $upgrade_check,
      path    => $thumbor::path,
      user    => $thumbor::user,
      group   => $thumbor::group,
      notify  => Class['thumbor::service'],
    }

    # Store current Thumbor and Python version information
    file { 'Version information':
      ensure  => file,
      path    => $upgrade_statefile,
      content => inline_epp('<%= $thumbor::version %>/<%= $python_version %><%= "\n" %>'),
      owner   => $thumbor::user,
      group   => $thumbor::group,
      require => Exec['upgrade venv'],
    }
  }
}
