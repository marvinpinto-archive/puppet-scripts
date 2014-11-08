class couchpotato::cron {

  include 'cron'

  cron::crontab {'cp-cleanup':
    minute       => '0',
    mailto       => '',
    hour         => '3',
    day_of_month => '*',
    month        => '*',
    day_of_week  => '*',
    command      => '/var/lib/couchpotato/cp-cleanup.sh',
    user         => 'root',
  }

}
