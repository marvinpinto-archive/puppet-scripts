class transmission::service {

  # Supervisor gets installed from the 'ubuntu universe' repo
  Apt::Source['ubuntu_universe'] -> Package['supervisor']

  require 'transmission::config'

  service { 'transmission-daemon':
    ensure => 'stopped',
    enable => false,
  }

  $supervisor_cmd = [
    '/usr/bin/transmission-daemon',
    '--foreground',
    '--config-dir=/var/lib/transmission',
  ]

  supervisor::service { 'transmission':
    ensure         => 'running',
    directory      => '/var/lib/transmission',
    user           => 'transmission',
    stopsignal     => 'INT',
    subscribe      => Class['transmission::config'],
    command        => shellquote($supervisor_cmd),
    require        => Service['transmission-daemon'],
    stdout_logfile => 'syslog',
    stderr_logfile => 'syslog',
  }

}
