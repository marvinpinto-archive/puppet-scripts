class python_yenc (
  $version = 'installed',
) {

  package { 'python-yenc':
    ensure  => $version,
    require => Apt::Source['ubuntu_universe'],
  }

}
