class deluge::package {

  # Add the deluge PPA
  apt::ppa { 'ppa:deluge-team/ppa': }

  package { 'deluged':
    ensure  => installed,
    require => Apt::Ppa['ppa:deluge-team/ppa'],
  }

  package { 'deluge-web':
    ensure  => installed,
    require => Apt::Ppa['ppa:deluge-team/ppa'],
  }

}
