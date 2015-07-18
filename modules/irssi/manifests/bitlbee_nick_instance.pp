define irssi::bitlbee_nick_instance (
  $nick_hashed_password,
  $accounts,
  $channels,
  $bitlbee_user = 'bitlbee',
  $bitlbee_group = 'bitlbee',
) {

  $nick = $title

  file {"/var/lib/bitlbee/${nick}.xml":
    ensure  => file,
    content => template('irssi/bitlbee-nick.xml.erb'),
    owner   => $bitlbee_user,
    group   => $bitlbee_group,
    mode    => '0400',
    notify  => Service['bitlbee'],
  }

}
