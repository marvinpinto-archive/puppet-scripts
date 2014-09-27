define procmail::instance (
  $maildir_loc,
  $maildir_user,
  $procmailrc_loc,
  $procmailrc_content,
  $maildir_group = 'root',
) {

  require 'procmail'

  file { $maildir_loc:
    ensure => directory,
    owner  => $maildir_user,
    group  => $maildir_group,
    mode   => '0750',
  }

  file { $procmailrc_loc:
    ensure  => present,
    content => $procmailrc_content,
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
  }

}
