class puppetclient(
  $pupstop_file,
  $private_confdir,
  $public_confdir,
  $deployment_private_key_contents,
  $deployment_private_key_loc,
  $public_repo_url,
  $private_repo_url,
  $git_puppet_ssh_wrapper_loc,
) {

  # The utils class contains git, amongst other things
  require 'utils'

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

  # Private key used to git-pull puppet config
  file { 'puppet-deployment-key':
    ensure  => present,
    path    => $deployment_private_key_loc,
    owner   => 'root',
    group   => 'root',
    mode    => '0400',
    content => $deployment_private_key_contents,
  }

  # Git wrapper around ssh in order to use specific private key files
  file { 'git-puppet-ssh':
    ensure  => present,
    path    => $git_puppet_ssh_wrapper_loc,
    owner   => 'root',
    group   => 'root',
    mode    => '0555',
    content => template('puppetclient/git_puppet_ssh.erb'),
    require => File['puppet-deployment-key'],
  }

  file { 'puppull':
    ensure  => present,
    path    => '/usr/local/bin/puppull',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('puppetclient/puppull.erb'),
    require => File['git-puppet-ssh'],
  }

}
