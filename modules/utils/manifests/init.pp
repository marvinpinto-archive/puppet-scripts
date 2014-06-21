class utils {

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
  ]

  package { $util_pkgs:
    ensure => installed,
  }

}
