class deluge::config (
  $media_group,
  $web_base,
  $unprocessed_downloads_prefix,
  $processed_downloads_prefix,
  $listen_port_start = hiera('deluge::firewall::listen_port_start'),
  $listen_port_end = hiera('deluge::firewall::listen_port_end'),
) {

  require 'deluge::user'

  file { '/etc/init/deluged.conf':
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('deluge/deluged.conf.erb'),
  }

  file { '/etc/init/deluge-web.conf':
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('deluge/deluge-web.conf.erb'),
  }

  $deluge_app_dirs = [
    '/var/lib/deluge/.config',
    '/var/lib/deluge/.config/deluge',
  ]

  file { $deluge_app_dirs:
    ensure => directory,
    mode   => '0775',
    owner  => 'root',
    group  => $media_group,
  }

  file { '/var/lib/deluge/.config/deluge/core.conf':
    ensure  => file,
    mode    => '0664',
    owner   => 'root',
    group   => $media_group,
    content => template('deluge/core.conf.erb'),
    require => File[$deluge_app_dirs],
  }

  file { '/var/lib/deluge/.config/deluge/auth':
    ensure  => file,
    mode    => '0600',
    owner   => 'deluge',
    group   => $media_group,
    source  => 'puppet:///modules/deluge/auth',
    require => File[$deluge_app_dirs],
  }

  file { '/var/lib/deluge/.config/deluge/execute.conf':
    ensure  => file,
    mode    => '0664',
    owner   => 'deluge',
    group   => $media_group,
    source  => 'puppet:///modules/deluge/execute.conf',
    require => File[$deluge_app_dirs],
  }

}
