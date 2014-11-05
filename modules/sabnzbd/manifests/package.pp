class sabnzbd::package {

  include 'unrar'
  include 'unzip'
  include 'par2'
  require 'sabnzbd::user'

  # Add the sabnzbd PPA
  apt::ppa { 'ppa:jcfp/ppa': }

  package { 'sabnzbdplus':
    ensure  => installed,
    require => Apt::Ppa['ppa:jcfp/ppa'],
  }

}
