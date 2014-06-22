define ssh::authorized_key (
  $key,
  $keyuser = $title,
  $ensure = 'present',
) {

  file { "ssh-auth-key-for-${keyuser}":
    path    => "/etc/ssh/KEYS/${keyuser}",
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => $key,
  }

}
