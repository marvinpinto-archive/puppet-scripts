class sickbeard::service {

  # Supervisor gets installed from the 'ubuntu universe' repo
  Apt::Source['ubuntu_universe'] -> Package['supervisor']

  require 'sickbeard::config'

  $supervisor_cmd = [
    '/usr/bin/python',
    'SickBeard.py',
    '--datadir=/var/lib/sickbeard',
    '--nolaunch',
    '--config=/var/lib/sickbeard/config.ini',
  ]

  supervisor::service { 'sickbeard':
    ensure     => 'running',
    directory  => '/opt/sickbeard',
    user       => 'sickbeard',
    stopsignal => 'INT',
    subscribe  => Class['sickbeard::config'],
    command    => shellquote($supervisor_cmd),
  }

}
