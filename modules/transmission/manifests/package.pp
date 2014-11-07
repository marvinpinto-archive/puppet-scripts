class transmission::package {

  # Add the transmission PPA
  apt::ppa { 'ppa:transmissionbt/ppa': }

  package { 'transmission-daemon':
    ensure  => installed,
    require => Apt::Ppa['ppa:transmissionbt/ppa'],
  }

  package { 'transmission-cli':
    ensure  => installed,
    require => Apt::Ppa['ppa:transmissionbt/ppa'],
  }

}
