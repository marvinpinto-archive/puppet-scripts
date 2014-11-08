class headphones::cron {

  include 'cron'

  cron::crontab {'hp-cleanup':
    minute       => '0',
    mailto       => '',
    hour         => '5',
    day_of_month => '*',
    month        => '*',
    day_of_week  => '*',
    command      => '/var/lib/headphones/hp-cleanup.sh',
    user         => 'root',
  }

}
