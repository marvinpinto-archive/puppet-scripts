class sabnzbd::config (
  $web_port,
  $oznab_api_key,
  $newsgroups_hostname,
  $newsgroups_username,
  $newsgroups_password,
) {

  require 'sabnzbd::user'

  file { '/var/lib/sabnzbd/sabnzbd.ini':
    ensure  => file,
    mode    => '0600',
    owner   => 'sabnzbd',
    group   => 'sabnzbd',
    content => template('sabnzbd/sabnzbd.ini.erb'),
  }

  file { '/etc/default/sabnzbdplus':
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('sabnzbd/etc-default-sabnzbdplus.erb'),
  }

}
