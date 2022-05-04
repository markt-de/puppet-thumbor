# @summary Install and configure Thumbor
#
# @param additional_packages
#   Specifies a list of additional packages that are required for thumbor or any of it's dependencies.
#
# @param config
#   The configuration for Thumbor. Note the hash keys will be converted to upper case.
#   You can refer to Thumbor wiki for configuration options: https://github.com/thumbor/thumbor/wiki/Configuration
#
# @param config_dir
#   Thumbor configuration files are stored in this directory if venv is not used
#
# @param ensure
#   Controls the installation and removal of application components (files, user, group), default present
#
# @param group
#   Name of the group to install (optional) and under which we run the thumbor service, default thumbor
#
# @param extensions
#   Extentions to install in thumbor virtual environment, default []
#
# @param listen
#   Host address to listen on, default 127.0.0.1
#
# @param manage_group
#   If we control the installation of the group, default true
#
# @param manage_python
#   If we control the installation of Python, default true
#
# @param manage_user
#   If we control the installation of the user, default true
#
# @param path
#   Specifies the content of the PATH environment variable when running commands.
#
# @param package_name
#   Package name of the thumbor application as found in pip, default thumbor
#
# @param package_ensure
#   Control the ensure on additional pip installations, default $ensure ('present')
#
# @param pip_proxyserver
#   The full url (including credentials) to a proxy server or undef to not use one at all, default undef
#
# @param ports
#   Array of port strings to let thumbor listen on. This also controls how many instances are spinned up. Default: [ '8000' ]
#
# @param python_config
#   Config for Python that should be used (if $manage_python is enabled)
#
# @param security_key
#   Security key to use in thumbor, default undef
#
# @param statefile
#   This file contains the version information, it is internally used to determine if a venv upgrade is necessary
#
# @param update_enabled
#   Whether to automatically update the Python venv if necessary. Note that
#   updates of the Thumbor PIP are controlled by the $version parameter.
#
# @param user
#   Name of the user to install (optional) and under which we run the thumbor service, default thumbor
#
# @param version
#   Version of Thumbor that should be installed, default 'present'
#
# @param virtualenv_path
#   If we use virtualenv (false if undef) and what path we use as base, default undef
#
class thumbor (
  Array $additional_packages,
  Hash $config,
  Stdlib::Absolutepath $config_dir,
  Enum['present', 'absent'] $ensure,
  Variant[Array[String],String] $extentions,
  String $group,
  String $listen,
  Boolean $manage_group,
  Boolean $manage_python,
  Boolean $manage_user,
  Enum['present', 'absent', 'latest'] $package_ensure,
  String $package_name,
  String $path,
  Optional[String] $pip_proxyserver,
  Variant[Array[String],String] $ports,
  Hash $python_config,
  Optional[String] $security_key,
  String $statefile,
  Boolean $update_enabled,
  String $user,
  String $version,
  Optional[Stdlib::Absolutepath] $virtualenv_path,
) {
  $apppath = $virtualenv_path ? {
    undef   => $config_dir,
    default => "${virtualenv_path}/",
  }

  anchor { 'thumbor::begin': }
  -> class{ 'thumbor::install': }
  -> class{ 'thumbor::upgrade': }
  -> class{ 'thumbor::config': }
  -> class{ 'thumbor::service': }
  -> anchor { 'thumbor::end': }
}
