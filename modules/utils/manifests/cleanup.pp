class utils::cleanup {

  $bad_pkgs = [
    'hddtemp',
    'mdadm',
    'smartmontools',
    'ufw',
    'apparmor',
    'apparmor-utils',
    'libapparmor-perl',
    'libapparmor1',
  ]

  package { $bad_pkgs:
    ensure => absent,
  }

  file { 'rtm-monitor':
    ensure  => absent,
    path    => '/usr/local/rtm',
    recurse => true,
    force   => true,
  }

}
