class sickbeard::config (
  $web_port,
  $web_base,
  $sabnzbd_port,
  $usenet_crawler_api_key,
) {

  require 'sickbeard::package'

  file { '/var/lib/sickbeard/config.ini':
    ensure  => file,
    mode    => '0664',
    owner   => 'sickbeard',
    group   => 'sickbeard',
    content => template('sickbeard/config.ini.erb'),
  }

}
