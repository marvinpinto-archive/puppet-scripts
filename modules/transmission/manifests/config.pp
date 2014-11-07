class transmission::config (
  $web_port,
  $web_base,
  $unprocessed_downloads_prefix,
  $firewall_port = hiera('transmission::firewall::port'),
) {

  require 'transmission::user'
  require 'transmission::package'

  file { '/var/lib/transmission/settings.json':
    ensure  => present,
    owner   => 'transmission',
    group   => 'transmission',
    mode    => '0600',
    content => template('transmission/settings.json.erb'),
  }

}
