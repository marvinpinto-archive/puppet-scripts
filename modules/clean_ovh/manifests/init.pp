class clean_ovh {

  $bad_pkgs = [
    'bind9',
    'hddtemp',
    'mdadm',
    'smartmontools'
  ]

  package { 'linux-image-server':
    ensure => installed,
  }

  package { $bad_pkgs:
    ensure => purged,
  }

  file { 'etc-crontab':
    path   => '/etc/crontab',
    ensure => file,
    source => "puppet:///modules/clean_ovh/crontab",
    owner  => 'root',
    group  => 'root',
  }

  file { 'rtm-monitor':
    path    => '/usr/local/rtm',
    ensure  => absent,
    recurse => true,
    force   => true,
  }

}

