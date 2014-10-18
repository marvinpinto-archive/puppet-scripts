class nginx::service {

  require 'nginx::config'

  service { 'nginx':
    ensure    => running,
    enable    => true,
    subscribe => Class['nginx::config'],
  }

}
