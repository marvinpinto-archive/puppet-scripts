class media_server {

  include 'nzb_post_processing'
  include 'media_server::ssl_certs'
  include 'media_server::nginx_config'
  include 'media_server::www_root'
  include 'media_server::users'
  include 'media_server::directories'
  include 'sabnzbd'
  include 'couchpotato'
  include 'sickbeard'
  include 'headphones'
  include 'plexapp'
  include 'transmission'

}
