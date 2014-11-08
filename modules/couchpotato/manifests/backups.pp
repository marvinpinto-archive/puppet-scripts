class couchpotato::backups (
  $s3_bucket_name,
  $s3_bucket_path,
  $s3_access_key_id,
  $s3_secret_access_key,
) {

  include 's3backups'
  include 'cron'

  s3backups::instance { 'couchpotato-database':
    s3bucket              => $s3_bucket_name,
    s3bucket_path         => $s3_bucket_path,
    src_backup_dir        => '/var/lib/couchpotato/database',
    dest_tarball_filename => 'couchpotato-database',
    syslog_tag            => 's3backup-cp-db',
    s3_access_key_id      => $s3_access_key_id,
    s3_secret_access_key  => $s3_secret_access_key,
  }

  cron::crontab {'cp-backup':
    minute       => '30',
    mailto       => '',
    hour         => '2',
    day_of_month => '*',
    month        => '*',
    day_of_week  => '*',
    command      => '/usr/local/bin/s3backup-couchpotato-database',
    user         => 'root',
  }

}
