class couchpotato::user (
  $media_group,
) {

  group { 'couchpotato':
    ensure => present,
    system => true;
  }

  $group_reqs = [
    Group['couchpotato'],
    Group[$media_group],
  ]

  user { 'couchpotato':
    ensure     => present,
    home       => '/var/lib/couchpotato',
    managehome => true,
    system     => true,
    gid        => 'couchpotato',
    groups     => $media_group,
    require    => $group_reqs,
  }

}
