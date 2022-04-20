# @summary Manage Thumbor system service and instances
# @api private
class thumbor::service {
  anchor { 'thumbor::service::begin': }
  -> systemd::unit_file { 'thumbor@.service':
    content => template('thumbor/thumbor.systemd.erb'),
  }
  -> thumbor::service::systemd{ [ $thumbor::ports ]: }
  -> anchor { 'thumbor::service::end': }
}
