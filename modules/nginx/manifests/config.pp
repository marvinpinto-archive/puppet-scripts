class nginx::config {

  # Please note that the nginx service resource subscribes to this class. What
  # that means is that any refresh events triggered by resources in this class
  # will bubble up and notify that service resource, which in turn will trigger
  # a service refresh. In other words, things that change in this class *will*
  # trigger nginx reloads!

  require 'nginx::install'

  file { '/etc/nginx':
    ensure => directory,
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }

  file { '/etc/nginx/conf.d':
    ensure  => directory,
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    recurse => true,
    purge   => true,
  }

  file { '/etc/nginx/nginx.conf':
    ensure  => present,
    mode    => '0444',
    owner   => 'root',
    group   => 'root',
    content => template('nginx/nginx.conf.erb'),
  }

}
