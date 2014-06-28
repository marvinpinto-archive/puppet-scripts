define users::group (
    $gid = undef,
) {

  group { $title:
    ensure => present,
    gid    => $gid,
  }

}
