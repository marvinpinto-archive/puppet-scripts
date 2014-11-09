class media_server::users (
  $media_group,
) {

  group { $media_group:
    ensure => present,
  }

}
