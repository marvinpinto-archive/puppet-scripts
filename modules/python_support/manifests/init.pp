class python_support (
  $version = 'installed',
) {

  package { 'python-support':
    ensure  => $version,
    require => Apt::Source['ubuntu_universe'],
  }

}
