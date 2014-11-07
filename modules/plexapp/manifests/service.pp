class plexapp::service {

  # Supervisor gets installed from the 'ubuntu universe' repo
  Apt::Source['ubuntu_universe'] -> Package['supervisor']

  require 'plexapp::config'

  service { 'plexmediaserver':
    ensure => 'stopped',
    enable => false,
  }

  $env_vars = [
    'PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS=6',
    'PLEX_MEDIA_SERVER_MAX_STACK_SIZE=3000',
    'PLEX_MEDIA_SERVER_TMPDIR=/tmp',
    'PLEX_MEDIA_SERVER_USER=plex',
    'PLEX_MEDIA_SERVER_USE_SYSLOG=true',
    'PLEX_MEDIA_SERVER_HOME=/usr/lib/plexmediaserver',
    'PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR="/var/lib/plexmediaserver/Library/Application Support"',
    'LD_LIBRARY_PATH=/usr/lib/plexmediaserver',
    'TMPDIR=/tmp',
  ]

  $supervisor_cmd = [
    '/usr/lib/plexmediaserver/Plex Media Server',
  ]

  supervisor::service { 'plexapp':
    ensure         => 'running',
    directory      => '/usr/lib/plexmediaserver',
    user           => 'plex',
    stopsignal     => 'INT',
    subscribe      => Class['plexapp::config'],
    environment    => join($env_vars, ','),
    command        => shellquote($supervisor_cmd),
    require        => Service['plexmediaserver'],
    stdout_logfile => 'syslog',
    stderr_logfile => 'syslog',
  }

  exec { 'load-plexapp-profiles':
    command     => '/var/lib/plexmediaserver/load_profiles.py',
    logoutput   => on_failure,
    require     => Supervisor::Service['plexapp'],
    subscribe   => Class['plexapp::config'],
    refreshonly => true,
  }

}
