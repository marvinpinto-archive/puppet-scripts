class media_server::www_root (
  $htpasswd_contents,
) {

  require 'media_server::nginx_config'

  file {'/opt/www':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    recurse => true,
    purge   => true,
    force   => true,
  }

  file {'/opt/www/index.html':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/media_server/index.html',
  }

  file {'/etc/nginx/.htpasswd':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => $htpasswd_contents,
  }

}
