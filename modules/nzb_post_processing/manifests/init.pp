class nzb_post_processing (
  $base_directory,
  $media_group,
  $bt_autoprocess_output_dir,
  $transmission_port,
) {

  file { $base_directory:
    ensure => directory,
    owner  => 'root',
    group  => $media_group,
    mode   => '0775',
  }

  vcsrepo { $base_directory:
    ensure   => present,
    provider => git,
    source   => 'https://github.com/clinton-hall/nzbToMedia.git',
    user     => 'root',
    group    => $media_group,
    require  => File[$base_directory],
  }

  file { "${base_directory}/autoProcessMedia.cfg":
    ensure  => file,
    owner   => 'root',
    group   => $media_group,
    mode    => '0644',
    content => template('nzb_post_processing/autoProcessMedia.cfg.erb'),
    require => Vcsrepo[$base_directory],
  }

}
