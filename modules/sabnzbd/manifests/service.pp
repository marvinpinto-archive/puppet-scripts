class sabnzbd::service (
  $web_port = hiera('sabnzbd::config::web_port'),
) {

  # Supervisor gets installed from the 'ubuntu universe' repo
  Apt::Source['ubuntu_universe'] -> Package['supervisor']

  require 'sabnzbd::config'

  $supervisor_cmd = [
    '/usr/bin/python',
    'SABnzbd.py',
    '--config-file=/var/lib/sabnzbd/sabnzbd.ini',
    "--server=127.0.0.1:${web_port}",
    '--clean',
    '--browser=0',
    '--logging=0',
    '--weblogging=0',
  ]

  supervisor::service { 'sabnzbd':
    ensure     => 'running',
    directory  => '/opt/sabnzbd',
    user       => 'sabnzbd',
    stopsignal => 'INT',
    subscribe  => Class['sabnzbd::config'],
    command    => shellquote($supervisor_cmd),
  }

}
