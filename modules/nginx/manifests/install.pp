class nginx::install {

  apt::source { 'nginx':
    location   => 'http://nginx.org/packages/mainline/ubuntu',
    repos      => 'nginx',
    key        => '7BD9BF62',
    key_server => 'pgp.mit.edu'
  }

  package { 'nginx':
    ensure  => 'latest',
    require => Apt::Source['nginx'],
  }

}
