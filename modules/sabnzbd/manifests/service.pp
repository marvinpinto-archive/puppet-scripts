class sabnzbd::service {

  require 'sabnzbd::config'

  service { 'sabnzbdplus':
    ensure    => running,
    subscribe => Class['sabnzbd::config'],
  }

}
