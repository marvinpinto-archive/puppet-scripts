define users::account (
    $pgroup,
    $groups,
    $fullname,
    $password_hash,
    $shell = '/bin/bash',
    $uid = undef,
) {

    user { $title:
      ensure     => present,
      uid        => $uid,
      gid        => $pgroup,
      groups     => $groups,
      comment    => $fullname,
      home       => "/home/${title}",
      shell      => $shell,
      allowdupe  => false,
      managehome => false,
      membership => 'inclusive',
      password   => $password_hash,
      require    => [
        Group[$pgroup],
        Group[$groups],
      ],
    }

    file { "/home/${title}":
      ensure  => directory,
      owner   => $title,
      group   => $pgroup,
      force   => true,
      mode    => '0700',
      require => User[$title],
    }

}
