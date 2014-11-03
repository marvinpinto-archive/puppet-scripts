class deluge::service {

  require 'deluge::config'

  service { 'deluged':
    ensure    => running,
    provider  => upstart,
    subscribe => Class['deluge::config'],
  }

  service { 'deluge-web':
    ensure    => running,
    provider  => upstart,
    subscribe => Class['deluge::config'],
  }

}
