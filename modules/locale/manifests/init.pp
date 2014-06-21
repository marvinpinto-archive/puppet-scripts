class locale {

  # I am not entirely sure all this is needed. But it seems to work, so..

  package {'language-pack-en':
    ensure => installed,
  }

  # Force the locale to en_US.UTF-8
  file { 'default-locale':
    path     => '/etc/default/locale',
    owner    => 'root',
    group    => 'root',
    mode     => '0644',
    content => 'LC_ALL="en_US.UTF-8"',
    notify   => Exec['dpkg-reconfigure-locales'],
    require  => Package['language-pack-en'],
  }

  # Force the default language to be en_US
  file { 'etc-environment':
    path     => '/etc/environment',
    owner    => 'root',
    group    => 'root',
    mode     => '0644',
    content => 'LANG=en_US',
    notify   => Exec['dpkg-reconfigure-locales'],
    require  => Package['language-pack-en'],
  }

  exec { 'dpkg-reconfigure-locales':
    command     => shellquote('/usr/sbin/dpkg-reconfigure', 'locales'),
    refreshonly => true,
    notify      => Exec['purge-unneeded-locales']
  }

  exec { 'purge-unneeded-locales':
    command     => shellquote('/usr/sbin/locale-gen', '--purge', 'en_US', 'en_US.UTF-8'),
    refreshonly => true,
    notify      => Exec['clean-apt-cache']
  }

  exec { 'clean-apt-cache':
    command     => shellquote('/bin/rm', '-rf', '/var/lib/apt/lists/*'),
    refreshonly => true,
    notify      => Exec['apt-update-for-locale-changes']
  }

  exec { 'apt-update-for-locale-changes':
    command     => shellquote('/usr/bin/apt-get', 'update'),
    refreshonly => true,
  }

}
