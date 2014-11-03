class sabnzbd::user (
  $media_group,
) {

  require 'sabnzbd::package'

  group { 'sabnzbd':
    ensure => present,
    system => true;
  }

  $group_reqs = [
    Group['sabnzbd'],
    Group[$media_group],
  ]

  user { 'sabnzbd':
    ensure     => present,
    home       => '/var/lib/sabnzbd',
    managehome => true,
    system     => true,
    gid        => 'sabnzbd',
    groups     => $media_group,
    require    => $group_reqs,
  }

}
