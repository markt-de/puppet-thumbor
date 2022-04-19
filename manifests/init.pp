# @summary Install and configure Thumbor
#
# @param ensure
#   If the thumbor application is installed or forcefully removed, default present
#
# @param security_key
#   Security key to use in thumbor, default undef
#
# @param listen
#   Host address to listen on, default 127.0.0.1
#
# @param ports
#   Array of port strings to let thumbor listen on. This also controls how many instances are spinned up. Default: [ '8000' ]
#
# @param virtualenv_path
#   If we use virtualenv (false if undef) and what path we use as base, default undef
#
# @param package_name
#   Package name of the thumbor application as found in pip, default thumbor
#
# @param package_ensure
#   Control the ensure on pip, default $ensure ('present')
#
# @param pip_proxyserver
#   The full url (including credentials) to a proxy server or undef to not use one at all, default undef
#
# @param ensure_user
#   If we control the installation of the user, default true
#
# @param user
#   Name of the user to install (optional) and under which we run the thumbor service, default thumbor
#
# @param ensure_group
#   If we control the installation of the group, default true
#
# @param group
#   Name of the group to install (optional) and under which we run the thumbor service, default thumbor
#
# @param extensions
#   Extentions to install in thumbor virtual environment, default []
#
# @param additional_packages
#   Specifies a list of additional packages that are required for thumbor or any of it's dependencies.
#
# @param manage_python
#   If we control the installation of Python, default true
#
class thumbor (
  Hash $config,
  Enum['present', 'absent'] $ensure = $thumbor::params::ensure,
  Optional[String] $security_key = $thumbor::params::security_key,
  String $listen = $thumbor::params::listen,
  Variant[Array[String],String] $ports = $thumbor::params::ports,
  Optional[String] $virtualenv_path = $thumbor::params::virtualenv_path,
  String $package_name = $thumbor::params::package_name,
  Enum['present', 'absent', 'latest'] $package_ensure = $thumbor::params::package_ensure,
  Optional[String] $pip_proxyserver = $thumbor::params::pip_proxyserver,
  Boolean $ensure_user = $thumbor::params::ensure_user,
  String $user = $thumbor::params::user,
  Boolean $ensure_group = $thumbor::params::ensure_group,
  String $group = $thumbor::params::group,
  Variant[Array[String],String] $extentions = $thumbor::params::extentions,
  Array $additional_packages = $thumbor::params::additional_packages,
  Boolean $manage_python = $thumbor::params::manage_python,
) inherits thumbor::params {
  $apppath = $virtualenv_path ? {
    undef   => '/usr/local/',
    default => "${virtualenv_path}/",
  }

  anchor { 'thumbor::begin': }
  -> class{ 'thumbor::install': }
  -> class{ 'thumbor::config': }
  -> class{ 'thumbor::service': }
  -> anchor { 'thumbor::end': }
}
