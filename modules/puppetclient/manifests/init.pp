class puppetclient(
  $pupstop_file,
  $confdir,
) {

  # Ensure that we have the newest available version of puppet
  package {'puppet':
    ensure => latest,
  }

  # We're running puppet masterless, so ensure the service never runs
  service {'puppet':
    ensure => stopped,
    enable => false,
  }

  file { 'pupgo':
    ensure  => present,
    path    => '/usr/local/bin/pupgo',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('puppetclient/pupgo.erb'),
    require => Package['puppet'],
  }

  file { 'pupstop':
    ensure  => present,
    path    => '/usr/local/bin/pupstop',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('puppetclient/pupstop.erb'),
    require => Package['puppet'],
  }

  file { 'puprun':
    ensure  => present,
    path    => '/usr/local/bin/puprun',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('puppetclient/puprun.erb'),
    require => Package['puppet'],
  }

}
