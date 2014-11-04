class unzip (
  $version = 'installed',
) {

  package { 'unzip':
    ensure  => $version,
    require => Apt::Source['ubuntu_main_restricted'],
  }

}
