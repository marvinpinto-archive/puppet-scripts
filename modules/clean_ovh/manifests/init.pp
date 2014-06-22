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


  file { 'rtm-monitor':
    ensure  => absent,
    path    => '/usr/local/rtm',
    recurse => true,
    force   => true,
  }

}

