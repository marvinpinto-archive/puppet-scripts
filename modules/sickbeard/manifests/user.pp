class sickbeard::user (
  $media_group,
) {

  group { 'sickbeard':
    ensure => present,
    system => true;
  }

  $group_reqs = [
    Group['sickbeard'],
    Group[$media_group],
  ]

  user { 'sickbeard':
    ensure     => present,
    home       => '/var/lib/sickbeard',
    managehome => true,
    system     => true,
    gid        => 'sickbeard',
    groups     => $media_group,
    require    => $group_reqs,
  }

}
