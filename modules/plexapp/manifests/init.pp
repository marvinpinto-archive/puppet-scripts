class plexapp {

  include 'plexapp::firewall'
  include 'plexapp::user'
  include 'plexapp::package'
  include 'plexapp::config'
  include 'plexapp::service'
  include 'plexapp::cron'

}
