class deluge::user (
  $media_group,
) {

  require 'deluge::package'

  group { 'deluge':
    ensure => present,
    system => true;
  }

  $group_reqs = [
    Group['deluge'],
    Group[$media_group],
  ]

  user { 'deluge':
    ensure     => present,
    home       => '/var/lib/deluge',
    managehome => true,
    system     => true,
    gid        => 'deluge',
    groups     => $media_group,
    require    => $group_reqs,
  }

}
