class thumbor::service {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  anchor { 'thumbor::service::begin': }
  -> systemd::unit_file { 'thumbor@.service':
    content => template('thumbor/thumbor.systemd.erb'),
  }
  -> thumbor::service::systemd{ [ $thumbor::ports ]: }
  -> anchor { 'thumbor::service::end': }
}
