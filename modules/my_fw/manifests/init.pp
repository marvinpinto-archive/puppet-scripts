class my_fw {

  # iptables-persistent gets installed from the 'ubuntu universe' repo
  Apt::Source['ubuntu_universe'] -> Package['iptables-persistent']

  # Explicitly specify resource ordering
  Firewall {
    before  => Class['my_fw::post'],
    require => Class['my_fw::pre'],
  }

  # Instantiate each of the firewall classes
  class { 'my_fw::pre': }
  class { 'my_fw::post': }
  class { 'firewall': }

  # Pull in the firewall rule values from hiera, if present
  create_resources('firewall', hiera_hash(my_fw::rules, {}))

}
