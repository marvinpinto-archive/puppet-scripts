class couchpotato::config (
  $web_port,
  $sabnzbd_port,
  $couchpotato_input_directory,
  $movies_directory,
  $bt_autoprocess_output_dir,
) {

  require 'couchpotato::package'

  file { '/var/lib/couchpotato/settings.conf':
    ensure  => file,
    mode    => '0644',
    owner   => 'couchpotato',
    group   => 'couchpotato',
    content => template('couchpotato/settings.conf.erb'),
  }

}
