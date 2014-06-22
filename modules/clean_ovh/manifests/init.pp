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
    path    => '/usr/local/rtm',
    ensure  => absent,
    recurse => true,
    force   => true,
  }

}

