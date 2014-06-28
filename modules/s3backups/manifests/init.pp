class s3backups {

  # Require apt + friends here before attempting to do anything
  require 'apt'

  $backup_pkgs = [
    'gnupg',
    'python-magic',
    's3cmd',
  ]

  package { $backup_pkgs:
    ensure => 'installed',
  }

  # Pull in the s3backups instance values from hiera, if present
  create_resources('s3backups::instance', hiera_hash(s3backups::instances, {}))

}
