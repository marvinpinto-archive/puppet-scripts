class sickbeard::backups (
  $s3_bucket_name,
  $s3_bucket_path,
  $s3_access_key_id,
  $s3_secret_access_key,
) {

  include 's3backups'
  include 'cron'

  s3backups::instance { 'sickbeard-database':
    s3bucket              => $s3_bucket_name,
    s3bucket_path         => $s3_bucket_path,
    src_backup_dir        => '/var/lib/sickbeard/sickbeard.db',
    dest_tarball_filename => 'sickbeard-database',
    syslog_tag            => 's3backup-sb-db',
    s3_access_key_id      => $s3_access_key_id,
    s3_secret_access_key  => $s3_secret_access_key,
  }

  cron::crontab {'sb-backup':
    minute       => '30',
    mailto       => '',
    hour         => '4',
    day_of_month => '*',
    month        => '*',
    day_of_week  => '*',
    command      => '/usr/local/bin/s3backup-sickbeard-database',
    user         => 'root',
  }

}
