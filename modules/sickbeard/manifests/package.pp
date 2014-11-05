class sickbeard::package {

  require 'sickbeard::user'

  file { '/opt/sickbeard':
    ensure => directory,
    owner  => 'sickbeard',
    group  => 'sickbeard',
    mode   => '0755',
  }

  vcsrepo { '/opt/sickbeard':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/midgetspy/Sick-Beard.git',
    user     => 'sickbeard',
    require  => File['/opt/sickbeard'],
    notify   => Supervisor::Service['sickbeard'],
  }

}
