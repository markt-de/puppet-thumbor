# @summary Setup a Thumbor service instance
#
# @param port
#   The port Thumbor listens on.
#
define thumbor::service::systemd (
  String $port = $name,
) {
  $service_name = "thumbor@${port}"

  service { $service_name:
    ensure    => 'running',
    enable    => true,
    require   => Systemd::Unit_file['thumbor@.service'],
    subscribe => [ Class['systemd::systemctl::daemon_reload'], File["${thumbor::apppath}/thumbor.conf"] ],
  }
}
