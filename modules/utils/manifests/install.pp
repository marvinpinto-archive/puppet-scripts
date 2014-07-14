class utils::install {

  # Utility packages I'll need installed
  $util_pkgs = [
    'git',
    'whois',
    'tmux',
    'ack-grep',
    'iftop',
    'htop',
    'curl',
    'dos2unix',
    'vim',
    'tree',
    'unzip',
  ]

  package { $util_pkgs:
    ensure => installed,
  }

}
