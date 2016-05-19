class nfs::client::ubuntu::service {

  case $::lsbdistcodename {
    'precise': {
      $provider = 'upstart'
      $service_name = 'rpcbind-boot'
    }
    default: {
      $provider = 'debian'
      $service_name = 'rpcbind'
    }
  }

  service { $service_name:
    ensure    => running,
    enable    => true,
    hasstatus => false,
    provider  => $provider,
  }

  if $nfs::client::ubuntu::nfs_v4 {
    if versioncmp($::lsbdistrelease, '16.04') < 0 {
      service { 'idmapd':
        ensure    => running,
        enable    => true,
        subscribe => Augeas['/etc/idmapd.conf', '/etc/default/nfs-common'],
      }
    }
  } else {
    service { 'idmapd':
      ensure => stopped,
      enable => false,
    }
  }
}
