class media_server::ssl_certs (
  $cert_location,
  $key_location,
  $cert_contents,
  $key_contents,
) {

  file { $cert_location:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => $cert_contents,
    notify  => Class['nginx::service'],
  }

  file { $key_location:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => $key_contents,
    notify  => Class['nginx::service'],
  }

}
