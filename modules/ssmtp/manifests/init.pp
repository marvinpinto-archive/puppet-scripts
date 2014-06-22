class ssmtp(
  $rootemail = undef,
  $smtp_server = undef,
  $smtp_port = undef,
  $username = undef,
  $password = undef,
  $override_from = undef,
  $use_tls = undef,
  $use_starttls = undef,
) {

  # Require apt & friends before we do anything here
  require 'apt'

  $mail_pkgs = [
    'ssmtp',
    'heirloom-mailx',
  ]

  package { $mail_pkgs:
    ensure => installed,
  }

  file { 'ssmtp.conf':
    ensure  => present,
    path    => '/etc/ssmtp/ssmtp.conf',
    require => Package[$mail_pkgs],
    content => template('ssmtp/ssmtp.conf.erb'),
  }

}
