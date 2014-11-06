class python_openssl (
  $version = 'installed',
) {

  package { 'python-openssl':
    ensure  => $version,
    require => Apt::Source['ubuntu_main_restricted'],
  }

}
