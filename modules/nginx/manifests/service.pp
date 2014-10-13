class nginx::service {

  require 'nginx::config'

  $nginx_reload_cmd = [
    '/usr/sbin/service', 'nginx', 'configtest',
    '&&',
    '/usr/sbin/service', 'nginx', 'reload',
  ]

  service { 'nginx':
    ensure    => running,
    enable    => true,
    subscribe => Class['nginx::config'],
    restart   => shellquote($nginx_reload_cmd),
  }

}
