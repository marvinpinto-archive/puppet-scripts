class python_feedparser (
  $version = 'installed',
) {

  package { 'python-feedparser':
    ensure  => $version,
    require => Apt::Source['ubuntu_main_restricted'],
  }

}
