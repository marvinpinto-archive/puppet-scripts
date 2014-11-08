class sickbeard::config (
  $web_port,
  $web_base,
  $sb_api_key,
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

  file { '/var/lib/sickbeard/sb-cleanup.sh':
    ensure  => file,
    mode    => '0755',
    owner   => 'sickbeard',
    group   => 'sickbeard',
    content => template('sickbeard/sb-cleanup.sh.erb'),
  }

}
