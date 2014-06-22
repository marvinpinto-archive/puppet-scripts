define cron::crontab (
  $mailto = '',
  $minute,
  $hour,
  $day_of_month,
  $month,
  $day_of_week,
  $command,
  $user,
  $enabled = 'true',
) {

  file { "crontab-entry-for-${name}":
    path    => "/etc/cron.d/${name}",
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0400',
    content => template('cron/crontab.erb'),
  }

}
