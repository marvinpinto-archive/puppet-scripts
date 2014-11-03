class deluge::firewall (
  $listen_port_start,
  $listen_port_end,
) {

  firewall { '300 allow connections to the bittorrent client':
    port   => "${listen_port_start}-${listen_port_end}",
    proto  => 'tcp',
    action => 'accept',
  }

}
