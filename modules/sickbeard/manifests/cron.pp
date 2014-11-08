class sickbeard::cron {

  include 'cron'

  cron::crontab {'sb-cleanup':
    minute       => '0',
    mailto       => '',
    hour         => '4',
    day_of_month => '*',
    month        => '*',
    day_of_week  => '*',
    command      => '/var/lib/sickbeard/sb-cleanup.sh',
    user         => 'root',
  }

}
