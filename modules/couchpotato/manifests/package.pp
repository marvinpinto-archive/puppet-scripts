class couchpotato::package {

  require 'couchpotato::user'

  file { '/opt/couchpotato':
    ensure => directory,
    owner  => 'couchpotato',
    group  => 'couchpotato',
    mode   => '0755',
  }

  vcsrepo { '/opt/couchpotato':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/RuudBurger/CouchPotatoServer.git',
    user     => 'couchpotato',
    require  => File['/opt/couchpotato'],
  }

}
