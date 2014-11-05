class couchpotato::config (
  $web_port,
  $sabnzbd_port,
  $couchpotato_input_directory,
  $movies_directory,
  $bt_autoprocess_output_dir,
  $usenet_crawler_api_key,
  $cp_api_key,
) {

  require 'couchpotato::package'

  file { '/var/lib/couchpotato/settings.conf':
    ensure  => file,
    mode    => '0644',
    owner   => 'couchpotato',
    group   => 'couchpotato',
    content => template('couchpotato/settings.conf.erb'),
  }

  file { '/var/lib/couchpotato/load_profiles.py':
    ensure  => file,
    mode    => '0755',
    owner   => 'couchpotato',
    group   => 'couchpotato',
    content => template('couchpotato/load_profiles.py.erb'),
  }

}
