class par2 (
  $version = 'installed',
) {

  package { 'par2':
    ensure => $version,
  }

}
