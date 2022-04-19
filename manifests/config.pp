# @summary Setup configuration files for Thumbor
class thumbor::config {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  $_default_config = deep_merge($thumbor::config, $thumbor::params::default_options)

  anchor { 'thumbor::config::begin': }
  -> file { "${thumbor::apppath}/thumbor.key":
    ensure  => $thumbor::package_ensure,
    content => $thumbor::security_key,
    owner   => $thumbor::user,
    group   => $thumbor::group,
    mode    => '0600',
  }
  -> file { "${thumbor::apppath}/thumbor.conf":
    ensure  => $thumbor::package_ensure,
    content => template('thumbor/thumbor.conf.erb'),
    owner   => $thumbor::user,
    group   => $thumbor::group,
    mode    => '0644',
  }
  -> anchor { 'thumbor::config::end': }
}
