class nfs::server::ubuntu::service {

  if $nfs::server::ubuntu::service_manage {

      service {'nfs-kernel-server':
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => true,
        require    => Package['nfs-kernel-server'],
        subscribe  => Concat['/etc/exports'],
      }


    Package['rpcbind'] -> Service['rpcbind']
  }
}
