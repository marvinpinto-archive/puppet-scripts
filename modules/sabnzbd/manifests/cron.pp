class sabnzbd::cron {

  include 'cron'

  cron::crontab {'sab-cleanup':
    minute       => '0',
    mailto       => '',
    hour         => '1',
    day_of_month => '*',
    month        => '*',
    day_of_week  => '*',
    command      => '/var/lib/sabnzbd/sab-cleanup.sh',
    user         => 'root',
  }

}
