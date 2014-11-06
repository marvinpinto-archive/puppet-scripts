class python_configobj (
  $version = 'installed',
) {

  package { 'python-configobj':
    ensure  => $version,
    require => Apt::Source['ubuntu_main_restricted'],
  }

}
