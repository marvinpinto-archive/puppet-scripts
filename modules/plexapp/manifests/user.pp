class plexapp::user (
  $media_group,
) {

  group { 'plex':
    ensure => present,
    system => true;
  }

  $group_reqs = [
    Group['plex'],
    Group[$media_group],
  ]

  user { 'plex':
    ensure     => present,
    home       => '/var/lib/plexmediaserver',
    managehome => true,
    system     => true,
    gid        => 'plex',
    groups     => $media_group,
    require    => $group_reqs,
  }

}
