class python_cheetah (
  $version = 'installed',
) {

  package { 'python-cheetah':
    ensure  => $version,
    require => Apt::Source['ubuntu_main_restricted'],
  }

}
