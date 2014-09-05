define irssi::instance (
  $irssi_user,
  $irssi_group,
  $settings,
  $chatnets = {},
  $channels = {},
  $hilights = {},
  $notifies = {},
  $ignores = {},
  $windows = {},
  $aliases = [],
  $instance_basedir = '/usr/local/etc',
  $instance_logdir = "/var/log/irssi-logs-${title}",
) {

  # Composed variables
  $irssi_dir = "${instance_basedir}/${title}"
  $instance_name = "${title}-irssi-instance"

  # Base irssi config directory (read-only)
  file { $irssi_dir:
    ensure  => directory,
    owner   => $irssi_user,
    group   => $irssi_group,
    force   => true,
    purge   => true,
    recurse => true,
    mode    => '0500',
  }

  # irssi directory for chat logs
  file { $instance_logdir:
    ensure  => directory,
    owner   => $irssi_user,
    group   => $irssi_group,
    mode    => '0700',
  }

  # irssi scripts directory
  file { "${irssi_dir}/scripts":
    ensure  => directory,
    owner   => $irssi_user,
    group   => $irssi_group,
    mode    => '0500',
    require => File[$irssi_dir],
  }

  # printlevels.pl (useful for debugging every once in a while)
  file { "${irssi_dir}/scripts/printlevels.pl":
    source  => 'puppet:///modules/irssi/printlevels.pl',
    owner   => $irssi_user,
    group   => $irssi_group,
    mode    => '0400',
    require => File["${irssi_dir}/scripts"],
  }

  # irssi scripts/autorun directory
  file { "${irssi_dir}/scripts/autorun":
    source  => 'puppet:///modules/irssi/scripts',
    recurse => true,
    purge   => true,
    owner   => $irssi_user,
    group   => $irssi_group,
    mode    => '0500',
    require => File["${irssi_dir}/scripts"],
  }

  # fear2 theme
  file { "${irssi_dir}/fear2.theme":
    source  => 'puppet:///modules/irssi/fear2.theme',
    owner   => $irssi_user,
    group   => $irssi_group,
    mode    => '0400',
    require => File[$irssi_dir],
  }

  # default theme
  file { "${irssi_dir}/default.theme":
    source  => 'puppet:///modules/irssi/default.theme',
    owner   => $irssi_user,
    group   => $irssi_group,
    mode    => '0400',
    require => File[$irssi_dir],
  }

  # config file
  file { "${irssi_dir}/config":
    content => template('irssi/config.erb'),
    owner   => $irssi_user,
    group   => $irssi_group,
    mode    => '0400',
    require => File[$irssi_dir],
  }

  # sasl.auth file
  file { "${irssi_dir}/sasl.auth":
    content => template('irssi/sasl.auth.erb'),
    owner   => $irssi_user,
    group   => $irssi_group,
    mode    => '0400',
    require => File[$irssi_dir],
  }

  # tmux.conf
  file { "${irssi_dir}/${instance_name}-tmux.conf":
    source  => 'puppet:///modules/irssi/tmux.conf',
    owner   => $irssi_user,
    group   => $irssi_group,
    mode    => '0400',
    require => File[$irssi_dir],
  }

  # startup file
  file { "${irssi_dir}/startup":
    source  => 'puppet:///modules/irssi/startup',
    owner   => $irssi_user,
    group   => $irssi_group,
    mode    => '0400',
    require => File[$irssi_dir],
  }

  # /etc/default file
  file { "/etc/default/${instance_name}":
    ensure  => file,
    content => template('irssi/irssi-default.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  # init.d file
  file { "/etc/init.d/${instance_name}":
    ensure  => file,
    content => template('irssi/irssi-init.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => File["/etc/default/${instance_name}"],
  }

  # Requirements before tmux/irssi can start under supervisor (these also
  # trigger service refreshes)
  $svc_reqs = [
    File["${irssi_dir}/sasl.auth"],
    File["${irssi_dir}/config"],
    File["${irssi_dir}/default.theme"],
    File["${irssi_dir}/fear2.theme"],
    File["${irssi_dir}/scripts/autorun"],
    File[$instance_logdir],
    File["${irssi_dir}/${instance_name}-tmux.conf"],
    File["${irssi_dir}/startup"],
    File["/etc/init.d/${instance_name}"],
    Service['bitlbee'],
  ]

  # And finally the (ghetto) init-based service that keeps this house of cards
  # from crumbling
  service { $instance_name:
    ensure    => 'running',
    enable    => true,
    subscribe => $svc_reqs,
    require   => File["/etc/init.d/${instance_name}"],
  }

}
