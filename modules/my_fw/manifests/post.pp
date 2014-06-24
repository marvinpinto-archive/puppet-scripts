class my_fw::post {

  # Final firewall rule that will be executed
  firewall { '999 drop all':
    proto  => 'all',
    action => 'drop',
    before => undef,
  }

}
