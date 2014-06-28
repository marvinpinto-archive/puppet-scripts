define s3backups::instance (
  $s3bucket,
  $s3bucket_path,
  $src_backup_dir,
  $dest_tarball_filename,
  $syslog_tag,
  $s3_access_key_id,
  $s3_secret_access_key,
  $s3cfg = "/usr/local/etc/${name}-s3cfg",
  $s3cmd = '/usr/bin/s3cmd',
) {

  # s3cmd config file
  file { $s3cfg:
    ensure  => file,
    content => template('s3backups/s3cfg.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0400',
  }

  # s3backup file (instance)
  file { "/usr/local/bin/s3backup-${name}":
    ensure  => file,
    content => template('s3backups/s3backup.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0544',
    require => File[$s3cfg],
  }

}
