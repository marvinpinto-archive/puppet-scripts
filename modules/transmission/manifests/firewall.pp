class transmission::firewall (
  $port,
) {

  firewall { '300 allow connections to the transmission client':
    port   => $port,
    proto  => 'tcp',
    action => 'accept',
  }

}
