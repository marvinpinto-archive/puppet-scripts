class unrar (
  $version = 'installed',
) {

  package { 'unrar':
    ensure => $version,
  }

}
