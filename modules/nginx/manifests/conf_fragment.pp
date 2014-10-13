# Approach borrowed from https://github.com/BenoitCattie/puppet-nginx/
# takes content, not a template path; that way we can decide what to hand it

define nginx::conf_fragment (
  $content,
  $ensure = 'present',
  $order = '500',
) {
  require 'nginx::config'

  file { "/etc/nginx/conf.d/${order}-${name}.conf":
    ensure  => $ensure,
    content => $content,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    notify  => Service['nginx'],
  }

}
