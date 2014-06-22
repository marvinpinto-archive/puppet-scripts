class ssh (
  $port = '22',
  $permit_root_login = 'no',
  $allow_password_auth = 'yes',
) {

  package { 'openssh-server':
    ensure => installed,
  }

  service { 'ssh':
    ensure    => running,
    enable    => true,
    require   => Package['openssh-server'],
    subscribe => File['/etc/ssh/sshd_config'],
  }

  file { '/etc/ssh':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => Package['openssh-server'],
  }

  file { '/etc/ssh/KEYS':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    recurse => true,
    purge   => true,
    require => File['/etc/ssh'],
  }

  file { '/etc/ssh/sshd_config':
    ensure  => present,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    path    => '/etc/ssh/sshd_config',
    content => template('ssh/sshd_config.erb'),
    require => File['/etc/ssh'],
  }

  file { '/etc/ssh/ssh_known_hosts':
    ensure  => present,
    mode    => '0444',
    owner   => 'root',
    group   => 'root',
    path    => '/etc/ssh/ssh_known_hosts',
    require => File['/etc/ssh'],
  }

  # Put in place some needed ssh host keys (if supplied). These values are
  # pulled in directly from hiera (see README.md for examples). This
  # essentially uses the puppet-defined 'sshkey' resource since there really is
  # no value in re-inventing the wheel here.
  create_resources('sshkey', hiera_hash('ssh::hostkeys', {}))

  # SSH Authorized Keys
  # These values can be pulled in directly from hiera (see README.md for
  # examples). The design-decision behind writing a custom define for this, vs
  # using puppet's 'ssh_authorized_key' resouce was that I need my ssh keys in
  # /etc/ssh/KEYS/%u. Using that resource, puppet attempts to do weird things
  # such as depend on said user, etc, which was way more than I needed.
  create_resources(
    'ssh::authorized_key',
    hiera_hash('ssh::authorized_keys', {})
  )

}
