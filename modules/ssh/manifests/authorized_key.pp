define ssh::authorized_key (
  $key,
  $keyuser = $title,
  $ensure = 'present',
) {

  file { "ssh-auth-key-for-${keyuser}":
    ensure  => $ensure,
    path    => "/etc/ssh/KEYS/${keyuser}",
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => $key,
  }

}
