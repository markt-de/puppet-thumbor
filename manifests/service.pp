# @summary Manage Thumbor system service and instances
# @api private
class thumbor::service {
  require(['thumbor::install', 'thumbor::config'])

  systemd::unit_file { 'thumbor@.service':
    content => template('thumbor/thumbor.systemd.erb'),
  }
  thumbor::service::systemd { [$thumbor::ports]:
    require => Systemd::Unit_file['thumbor@.service'],
  }
}
