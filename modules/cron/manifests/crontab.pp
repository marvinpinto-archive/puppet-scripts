define cron::crontab (
  $minute,
  $hour,
  $day_of_month,
  $month,
  $day_of_week,
  $command,
  $user,
  $mailto = '',
  $enabled = 'yes',
) {

  file { "crontab-entry-for-${name}":
    ensure  => file,
    path    => "/etc/cron.d/${name}",
    owner   => 'root',
    group   => 'root',
    mode    => '0400',
    content => template('cron/crontab.erb'),
  }

}
