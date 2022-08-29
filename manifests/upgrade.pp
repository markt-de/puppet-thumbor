# @summary Upgrade Thumbor's Python venv
# @api private
class thumbor::upgrade {
  # Only perform upgrades when using Python venv.
  if $thumbor::update_enabled and $thumbor::venv_path {
    $upgrade_statefile = "${thumbor::config_dir}/${thumbor::statefile}"

    # Get the Python version that should be used for Thumbor's venv.
    if ($thumbor::manage_python and $thumbor::python_config and 'version' in $thumbor::python_config) {
      $_python_version = regsubst($thumbor::python_config['version'], '[^0-9.]', '', 'G')
    } elsif ('python3_release' in $facts) {
      $_python_version = regsubst($facts['python3_release'], '[^0-9.]', '', 'G')
    }

    # Fallback if the Python version is still unknown.
    if (!defined('$_python_version') or empty($_python_version)) {
      $python_version = '3'
    } else {
      $python_version = $_python_version
    }

    # Try to guess the name of the Python binary.
    # It is usually something like python3 or python3.8.
    $python_bin = "python${python_version}"

    # Check if upgrade is necessary by comparing version information.
    # It is ensured that the initial installation is already complete by
    # verifying that the venv directory exists.
    $upgrade_check = join([
        "test -d ${thumbor::venv_path}/bin",
        "&& ! grep '^${thumbor::version}/${python_version}$' ${upgrade_statefile}",
    ], ' ')
    $upgrade_cmd = "${python_bin} -m venv --upgrade ${thumbor::venv_path}"

    # Run the command to upgrade the venv
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
