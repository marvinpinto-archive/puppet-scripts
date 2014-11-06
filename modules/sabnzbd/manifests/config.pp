class sabnzbd::config (
  $web_port,
  $oznab_api_key,
  $newsgroups_hostname,
  $newsgroups_username,
  $newsgroups_password,
  $couchpotato_input_directory,
  $nzb_post_processing_directory,
  $unprocessed_downloads_prefix,
  $processed_downloads_prefix,
  $tv_directory,
) {

  require 'sabnzbd::package'

  file { '/var/lib/sabnzbd/sabnzbd.ini':
    ensure  => file,
    mode    => '0600',
    owner   => 'sabnzbd',
    group   => 'sabnzbd',
    content => template('sabnzbd/sabnzbd.ini.erb'),
  }

}
