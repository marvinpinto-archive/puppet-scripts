class my_fw::pre (
  $ssh_rate_limit = '12/min',
  $ssh_port = hiera('ssh::port'),
) {

  Firewall {
    require => undef,
  }

  #
  # Default firewall rules
  #

  firewall { '000 accept all icmp':
    proto  => 'icmp',
    action => 'accept',
  }

  firewall { '001 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
    require => Firewall['000 accept all icmp'],
  }

  firewall { '002 accept related established rules':
    proto   => 'all',
    state   => ['RELATED', 'ESTABLISHED'],
    action  => 'accept',
    require => Firewall['001 accept all to lo interface'],
  }

  firewall { '003 allow SSH access':
    port    => $ssh_port,
    proto   => tcp,
    action  => accept,
    limit   => $ssh_rate_limit,
    require => Firewall['002 accept related established rules'],
  }

}
