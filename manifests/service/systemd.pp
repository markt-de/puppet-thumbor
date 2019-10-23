define thumbor::service::systemd
(
  String $port = String("${name}"),
)
{
  $service_name = "thumbor@${port}"

  service { $service_name:
    enable    => true,
    ensure    => 'running',
    require   => Systemd::Unit_file['thumbor@.service'],
    subscribe => [ Class['systemd::systemctl::daemon_reload'], File["${thumbor::apppath}/thumbor.conf"] ],
  }
}
