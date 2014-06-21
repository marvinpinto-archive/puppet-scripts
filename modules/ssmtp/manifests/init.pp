class ssmtp(
  $rootemail,
  $smtp_server,
  $smtp_port,
  $username,
  $password,
  $override_from,
  $use_tls,
  $use_starttls,
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
    path    => '/etc/ssmtp/ssmtp.conf',
    ensure  => present,
    require => Package[$mail_pkgs],
    content => template("ssmtp/ssmtp.conf.erb"),
  }

}
