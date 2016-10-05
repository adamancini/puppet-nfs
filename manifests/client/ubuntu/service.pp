class nfs::client::ubuntu::service {

  case $::lsbdistcodename {
    'precise' : { $provider = 'upstart' }
    default   : { $provider = 'debian' }
  }

  service { 'rpcbind':
    ensure    => running,
    enable    => true,
    hasstatus => false,
    provider  => $provider,
  }

  if $nfs::client::ubuntu::nfs_v4 {
    service { 'idmapd':
      ensure    => running,
      enable    => true,
      subscribe => Augeas['/etc/idmapd.conf', '/etc/default/nfs-common'],
    }
  } else {
    service { 'idmapd':
      ensure => stopped,
      enable => false,
    }
  }
}
