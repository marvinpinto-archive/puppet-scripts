class couchpotato::service {

  # Supervisor gets installed from the 'ubuntu universe' repo
  Apt::Source['ubuntu_universe'] -> Package['supervisor']

  require 'couchpotato::config'

  $supervisor_cmd = [
    '/usr/bin/python',
    'CouchPotato.py',
    '--data_dir=/var/lib/couchpotato',
    '--config_file=/var/lib/couchpotato/settings.conf',
  ]

  supervisor::service { 'couchpotato':
    ensure         => 'running',
    directory      => '/opt/couchpotato',
    user           => 'couchpotato',
    stopsignal     => 'INT',
    subscribe      => Class['couchpotato::config'],
    command        => shellquote($supervisor_cmd),
    stdout_logfile => 'syslog',
    stderr_logfile => 'syslog',
  }

  exec { 'load-couchpotato-profiles':
    command     => '/var/lib/couchpotato/load_profiles.py',
    logoutput   => on_failure,
    require     => Supervisor::Service['couchpotato'],
    subscribe   => Class['couchpotato::config'],
    refreshonly => true,
  }

}
