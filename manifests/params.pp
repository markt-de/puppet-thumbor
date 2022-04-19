class thumbor::params (
  Enum['present', 'absent'] $ensure = 'present',
  Optional[String] $security_key = undef,
  String $listen = '127.0.0.1',
  Variant[Array[String],String] $ports = [ '8000' ],
  Optional[String] $virtualenv_path = undef,
  String $package_name = 'thumbor',
  String $package_ensure = $ensure,
  Optional[String] $pip_proxyserver = undef,
  Boolean $ensure_user = true,
  String $user = 'thumbor',
  Boolean $ensure_group = true,
  String $group = 'thumbor',
  Variant[Array[String],String] $extentions = [],
  Hash $default_options = {},
  Boolean $manage_python = true,
) {
  case $facts['os']['family'] {
    'Debian': {
      $additional_packages = ['build-essential',
                              'gifsicle',
                              'libcurl4-openssl-dev',
                              'libglib2.0-0',
                              'libjpeg-turbo-progs',
                              'libsm6',
                              'libssl-dev',
                              'libxext6',
                              'libxrender1']
    }
    'RedHat': {
      $additional_packages = ['automake',
                              'gcc',
                              'gcc-c++',
                              'gifsicle',
                              'glib2',
                              'libcurl-devel',
                              'libjpeg-turbo',
                              'libSM',
                              'libXext',
                              'libXrender',
                              'make',
                              'openssl-devel',
                              'openssl-libs']
    }
    default: {
      fail("Operating system ${facts['os']['family']} is not currently supported in module ${module_name}")
    }
  }
}
