class headphones::user (
  $media_group,
) {

  group { 'headphones':
    ensure => present,
    system => true;
  }

  $group_reqs = [
    Group['headphones'],
    Group[$media_group],
  ]

  user { 'headphones':
    ensure     => present,
    home       => '/var/lib/headphones',
    managehome => true,
    system     => true,
    gid        => 'headphones',
    groups     => $media_group,
    require    => $group_reqs,
  }

}
