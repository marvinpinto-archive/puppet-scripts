class irssi (
  $bitlbee_user = 'bitlbee',
  $bitlbee_group = 'bitlbee',
  $bitlbee_port = '6667',
) {

  $irssi_pkgs = [
    'irssi',
    'irssi-plugin-xmpp',
    'irssi-scripts',
    'libdbi-perl',
    'libdigest-hmac-perl',
    'libgssapi-perl',
    'libdata-dump-perl',
    'libcrypt-ssleay-perl',
    'libauthen-ntlm-perl',
    'libcrypt-blowfish-perl',
    'libcrypt-dh-perl',
    'libcrypt-openssl-bignum-perl',
    'aspell-en',
    'aspell',
    'libtext-aspell-perl',
    'bitlbee',
  ]

  # We'll need tmux + friends before anything can be done here
  require 'utils'

  package { $irssi_pkgs:
    ensure => 'installed',
  }

  # bitlbee message of the day
  file { '/etc/bitlbee/motd.txt':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    source  => 'puppet:///modules/irssi/bitlbee-motd.txt',
    require => Package[$irssi_pkgs],
  }

  # bitlbee config file
  file { '/etc/bitlbee/bitlbee.conf':
    ensure  => file,
    owner   => 'root',
    group   => $bitlbee_group,
    mode    => '0440',
    content => template('irssi/bitlbee.conf.erb'),
    require => Package[$irssi_pkgs],
  }

  # bitlbee init default file
  file { '/etc/default/bitlbee':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => template('irssi/etc-default-bitlbee.erb'),
    require => Package[$irssi_pkgs],
  }

  # Bitlbee service requirements
  $svc_reqs = [
    File['/etc/bitlbee/motd.txt'],
    File['/etc/bitlbee/bitlbee.conf'],
    File['/etc/default/bitlbee'],
  ]

  # pgrep was neded below because the default bitlbee init script (for ubuntu)
  # does not contain a 'status' option. The '-u' matches the bitlbee user and
  # '6667' matches the default port stock bitlbee is configured to run on. The
  # '-f' specifies that we should match the pattern against the full command
  # line string.
  $status_cmd = shellquote(
    '/usr/bin/pgrep',
    '-f',
    '-u',
    $bitlbee_user,
    $bitlbee_port
  )
  service { 'bitlbee':
    ensure    => running,
    enable    => true,
    hasstatus => false,
    status    => $status_cmd,
    require   => $svc_reqs,
    subscribe => $svc_reqs,
  }

  # Pull in the bitlbee instance values from hiera, if present
  create_resources(
    'irssi::bitlbee_nick_instance',
    hiera_hash(irssi::bitlbee_nick_instances, {})
  )

  # Pull in the irssi instance values from hiera, if present
  create_resources('irssi::instance', hiera_hash(irssi::instances, {}))

}
