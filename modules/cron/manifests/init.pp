class cron {

  package {'cron':
    ensure => installed,
  }

  service {'cron':
    ensure  => running,
    require => Package['cron'],
  }

  file { 'etc-crontab':
    ensure => file,
    path   => '/etc/crontab',
    source => 'puppet:///modules/cron/crontab',
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
  }

  # Get rid of anything in here that's not managed by us
  file { 'etc-cron.d':
    ensure  => directory,
    path    => '/etc/cron.d',
    owner   => 'root',
    group   => 'root',
    mode    => '0655',
    purge   => true,
    recurse => true,
  }

  # This placeholder file is apparently needed by dpkg. This isn't ghetto at
  # all.
  file { 'etc-cron.d-placeholder':
    ensure => file,
    path   => '/etc/cron.d/.placeholder',
    source => 'puppet:///modules/cron/placeholder',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  # Pull in the crontab values from hiera, if present
  create_resources('cron::crontab', hiera_hash(cron::crontabs, {}))
}
