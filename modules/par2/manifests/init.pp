class par2 (
  $version = 'installed',
) {

  package { 'par2':
    ensure  => $version,
    require => Apt::Source['ubuntu_universe'],
  }

}
