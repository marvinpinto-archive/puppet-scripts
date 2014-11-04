class sabnzbd::package {

  require 'unrar'
  require 'unzip'
  require 'par2'
  require 'sabnzbd::user'

  # Add the sabnzbd PPA
  apt::ppa { 'ppa:jcfp/ppa': }

  package { 'sabnzbdplus':
    ensure  => installed,
    require => Apt::Ppa['ppa:jcfp/ppa'],
  }

}
