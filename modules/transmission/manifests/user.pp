class transmission::user (
  $media_group,
) {

  group { 'transmission':
    ensure => present,
    system => true;
  }

  $group_reqs = [
    Group['transmission'],
    Group[$media_group],
  ]

  user { 'transmission':
    ensure     => present,
    home       => '/var/lib/transmission',
    managehome => true,
    system     => true,
    gid        => 'transmission',
    groups     => $media_group,
    require    => $group_reqs,
  }

}
