class plexapp::package (
  $private_apt_repo_url,
  $plex_version,
) {

  require 'plexapp::user'

  apt::source { 'unstable_io':
    location => $private_apt_repo_url,
    repos    => 'binary/',
    release  => '',
  }

  apt::source { 'plexmediaserver':
    location    => 'http://plex.r.worldssl.net/PlexMediaServer/ubuntu-repo',
    repos       => 'main',
    release     => 'lucid',
    include_src => false,
  }

  $srcs_list = [
    Apt::Source['unstable_io'],
    Apt::Source['plexmediaserver'],
  ]

  package { 'plexmediaserver':
    ensure  => $plex_version,
    require => $srcs_list,
  }

}
