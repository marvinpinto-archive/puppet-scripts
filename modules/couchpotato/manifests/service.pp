class couchpotato::service {

  require 'couchpotato::config'

  $supervisor_cmd = [
    '/usr/bin/python',
    'CouchPotato.py',
    '--data_dir=/var/lib/couchpotato',
    '--config_file=/var/lib/couchpotato/settings.conf',
  ]

  supervisor::service { 'couchpotato':
    ensure     => 'running',
    directory  => '/opt/couchpotato',
    user       => 'couchpotato',
    stopsignal => 'INT',
    subscribe  => Class['couchpotato::config'],
    command    => shellquote($supervisor_cmd),
  }

}
