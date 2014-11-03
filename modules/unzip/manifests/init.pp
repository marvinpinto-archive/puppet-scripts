class unzip (
  $version = 'installed',
) {

  package { 'unzip':
    ensure => $version,
  }

}
