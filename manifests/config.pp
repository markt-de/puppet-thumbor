# @summary Setup configuration files for Thumbor
# @api private
class thumbor::config {
  $_default_config = $thumbor::config

  anchor { 'thumbor::config::begin': }
  -> file { "${thumbor::cfg_path}/thumbor.key":
    ensure  => $thumbor::ensure,
    content => $thumbor::security_key,
    owner   => $thumbor::user,
    group   => $thumbor::group,
    mode    => '0600',
  }
  -> file { "${thumbor::cfg_path}/thumbor.conf":
    ensure  => $thumbor::ensure,
    content => epp('thumbor/thumbor.conf.epp', {
        _default_config => $_default_config,
    }),
    owner   => $thumbor::user,
    group   => $thumbor::group,
    mode    => '0644',
  }
  -> anchor { 'thumbor::config::end': }
}
