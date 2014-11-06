class sabnzbd::package {

  include 'unrar'
  include 'unzip'
  include 'par2'
  include 'python_yenc'
  include 'python_feedparser'
  include 'python_support'
  include 'python_cheetah'
  include 'python_configobj'
  include 'python_dbus'
  include 'python_openssl'
  require 'sabnzbd::user'

  file { '/opt/sabnzbd':
    ensure => directory,
    owner  => 'sabnzbd',
    group  => 'sabnzbd',
    mode   => '0755',
  }

  vcsrepo { '/opt/sabnzbd':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/sabnzbd/sabnzbd.git',
    user     => 'sabnzbd',
    require  => File['/opt/sabnzbd'],
    notify   => Supervisor::Service['sabnzbd'],
  }

}
