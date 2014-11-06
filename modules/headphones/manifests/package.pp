class headphones::package {

  require 'headphones::user'

  file { '/opt/headphones':
    ensure => directory,
    owner  => 'headphones',
    group  => 'headphones',
    mode   => '0755',
  }

  vcsrepo { '/opt/headphones':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/rembo10/headphones.git',
    user     => 'headphones',
    require  => File['/opt/headphones'],
    notify   => Supervisor::Service['headphones'],
  }

}
