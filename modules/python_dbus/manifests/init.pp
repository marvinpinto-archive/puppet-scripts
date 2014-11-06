class python_dbus (
  $version = 'installed',
) {

  package { 'python-dbus':
    ensure  => $version,
    require => Apt::Source['ubuntu_main_restricted'],
  }

}
