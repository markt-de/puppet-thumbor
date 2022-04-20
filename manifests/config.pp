# @summary Setup configuration files for Thumbor
# @api private
class thumbor::config {
  $_default_config = deep_merge($thumbor::config, $thumbor::default_options)

  anchor { 'thumbor::config::begin': }
  -> file { "${thumbor::apppath}/thumbor.key":
    ensure  => $thumbor::ensure,
    content => $thumbor::security_key,
    owner   => $thumbor::user,
    group   => $thumbor::group,
    mode    => '0600',
  }
  -> file { "${thumbor::apppath}/thumbor.conf":
    ensure  => $thumbor::ensure,
    content => template('thumbor/thumbor.conf.erb'),
    owner   => $thumbor::user,
    group   => $thumbor::group,
    mode    => '0644',
  }
  -> anchor { 'thumbor::config::end': }
}
