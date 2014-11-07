class headphones::service {

  # Supervisor gets installed from the 'ubuntu universe' repo
  Apt::Source['ubuntu_universe'] -> Package['supervisor']

  require 'headphones::config'

  $supervisor_cmd = [
    '/usr/bin/python',
    'Headphones.py',
    '--quiet',
    '--nolaunch',
    '--datadir=/var/lib/headphones',
    '--config=/var/lib/headphones/config.ini'
  ]

  supervisor::service { 'headphones':
    ensure         => 'running',
    directory      => '/opt/headphones',
    user           => 'headphones',
    stopsignal     => 'INT',
    subscribe      => Class['headphones::config'],
    command        => shellquote($supervisor_cmd),
    stdout_logfile => 'syslog',
    stderr_logfile => 'syslog',
  }

}
