class plexapp::cron {

  include 'cron'

  cron::crontab {'plex-cleanup':
    minute       => '0',
    mailto       => '',
    hour         => '2',
    day_of_month => '*',
    month        => '*',
    day_of_week  => '*',
    command      => '/var/lib/plexmediaserver/plex-cleanup.sh',
    user         => 'root',
  }

}
