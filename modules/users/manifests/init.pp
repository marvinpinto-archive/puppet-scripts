class users (
  $sudo_notify_email = undef,
) {

  # In order to send out email
  require 'ssmtp'

  file { '/etc/sudoers':
    ensure       => file,
    owner        => 'root',
    group        => 'root',
    mode         => '0440',
    validate_cmd => '/usr/sbin/visudo -cf %',
    content      => template('users/sudoers.erb'),
  }

  # From now all, all sudoers will go in the 'admins' group
  file { '/etc/sudoers.d':
    ensure  => absent,
    force   => true,
    recurse => true,
    purge   => true,
  }

  # Pull in the user account from hiera, if present
  create_resources('users::account', hiera_hash(users::accounts, {}))

  # Pull in the user groups from hiera, if present
  create_resources('users::group', hiera_hash(users::groups, {}))

}
