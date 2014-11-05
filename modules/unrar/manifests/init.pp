class unrar (
  $version = 'installed',
) {

  package { 'unrar':
    ensure  => $version,
    require => Apt::Source['ubuntu_multiverse'],
  }

}
