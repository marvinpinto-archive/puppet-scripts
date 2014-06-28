class verbose_boot {

  # Enable verbose boot
  file {'etc-default-grub':
    ensure => file,
    path   => '/etc/default/grub',
    source => 'puppet:///modules/verbose_boot/grub',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Exec['update-grub'],
  }

  # Update grub only when the 'etc-default-grub' file changes
  exec { 'update-grub':
    command     => '/usr/sbin/update-grub',
    refreshonly => true,
    logoutput   => on_failure,
  }

}
