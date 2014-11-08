class plexapp::config (
  $friendly_name,
  $machine_identifier,
  $processed_machine_identifier,
  $tv_directory,
  $movies_directory,
  $music_directory,
) {

  require 'plexapp::package'

  $plex_dirs = [
    '/var/lib/plexmediaserver/Library',
    '/var/lib/plexmediaserver/Library/Application Support',
    '/var/lib/plexmediaserver/Library/Application Support/Plex Media Server',
  ]

  file { $plex_dirs:
    ensure => directory,
    owner  => 'plex',
    group  => 'plex',
    mode   => '0775',
  }

  file { 'plex-preferences':
    ensure  => present,
    path    => '/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Preferences.xml',
    owner   => 'plex',
    group   => 'plex',
    mode    => '0440',
    content => template('plexapp/plex-preferences.xml.erb'),
  }

  file { '/var/lib/plexmediaserver/load_profiles.py':
    ensure  => file,
    mode    => '0755',
    owner   => 'plex',
    group   => 'plex',
    content => template('plexapp/load_profiles.py.erb'),
  }

  file { '/var/lib/plexmediaserver/plex-cleanup.sh':
    ensure  => file,
    mode    => '0755',
    owner   => 'plex',
    group   => 'plex',
    content => template('plexapp/plex-cleanup.sh.erb'),
  }

}
