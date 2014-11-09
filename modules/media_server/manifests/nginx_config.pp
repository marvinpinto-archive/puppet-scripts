class media_server::nginx_config (
  $server_name,
  $sabnzbd_web_port = hiera('sabnzbd::config::web_port'),
  $couchpotato_web_port = hiera('couchpotato::config::web_port'),
  $sickbeard_web_port = hiera('sickbeard::config::web_port'),
  $sickbeard_web_base = hiera('sickbeard::config::web_base'),
  $headphones_web_port = hiera('headphones::config::web_port'),
  $headphones_web_base = hiera('headphones::config::web_base'),
  $transmission_web_port = hiera('transmission::config::web_port'),
  $transmission_web_base = hiera('transmission::config::web_base'),
  $ssl_cert_location = hiera('media_server::ssl_certs::cert_location'),
  $ssl_key_location = hiera('media_server::ssl_certs::key_location'),
  $ssl_cipher_suite = hiera('nginx::sslciphersuite'),
) {

  require 'nginx'
  require 'media_server::ssl_certs'

  nginx::conf_fragment { 'media-server':
    content => template('media_server/nginx.conf.erb'),
  }

  firewall { '300 allow tcp access to port 443':
    port   => '443',
    proto  => 'tcp',
    action => 'accept',
  }

}
