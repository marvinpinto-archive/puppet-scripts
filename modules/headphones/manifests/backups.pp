class headphones::backups (
  $s3_bucket_name,
  $s3_bucket_path,
  $s3_access_key_id,
  $s3_secret_access_key,
) {

  include 's3backups'
  include 'cron'

  s3backups::instance { 'headphones-database':
    s3bucket              => $s3_bucket_name,
    s3bucket_path         => $s3_bucket_path,
    src_backup_dir        => '/var/lib/headphones/headphones.db',
    dest_tarball_filename => 'headphones-database',
    syslog_tag            => 's3backup-hp-db',
    s3_access_key_id      => $s3_access_key_id,
    s3_secret_access_key  => $s3_secret_access_key,
  }

  cron::crontab {'hp-backup':
    minute       => '30',
    mailto       => '',
    hour         => '3',
    day_of_month => '*',
    month        => '*',
    day_of_week  => '*',
    command      => '/usr/local/bin/s3backup-headphones-database',
    user         => 'root',
  }

}
