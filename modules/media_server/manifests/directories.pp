class media_server::directories (
  $media_group = hiera('media_server::users::media_group'),
  $unprocessed_downloads_prefix,
  $processed_downloads_prefix,
  $couchpotato_input_directory,
  $headphones_input_directory,
  $movies_directory,
  $tv_directory,
  $music_directory,
  $bt_autoprocess_output_dir,
) {

  require 'media_server::users'

  $dirs_to_manage = [
    $unprocessed_downloads_prefix,
    $processed_downloads_prefix,
    $couchpotato_input_directory,
    $headphones_input_directory,
    $movies_directory,
    $tv_directory,
    $music_directory,
    $bt_autoprocess_output_dir,
  ]

  file { $dirs_to_manage:
    ensure => directory,
    owner  => 'root',
    group  => $media_group,
    mode   => '0775',
  }

}
