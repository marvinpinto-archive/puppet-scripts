class headphones::config (
  $web_port,
  $web_base,
  $headphones_input_directory,
  $usenet_crawler_api_key,
  $sabnzbd_port,
  $music_directory,
  $bt_autoprocess_output_dir,
  $transmission_port,
) {

  require 'headphones::package'

  file { '/var/lib/headphones/config.ini':
    ensure  => file,
    mode    => '0644',
    owner   => 'headphones',
    group   => 'headphones',
    content => template('headphones/config.ini.erb'),
  }

}
