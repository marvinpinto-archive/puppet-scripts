class plexapp::firewall {

  firewall { '300 allow tcp access to port 32400':
    port   => '32400',
    proto  => 'tcp',
    action => 'accept',
  }

  firewall { '300 allow udp access to port 32400':
    port   => '32400',
    proto  => 'udp',
    action => 'accept',
  }

}
