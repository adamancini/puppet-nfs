# Debian specifix stuff
class nfs::server::ubuntu(
  $nfs_v4              = false,
  $nfs_v4_idmap_domain = undef,
  $mountd_port         = undef,
  $mountd_threads      = 1,
  $service_manage      = true,
) {

  if !defined(Class['nfs::client::ubuntu']) {
    class{ 'nfs::client::ubuntu':
      nfs_v4              => $nfs_v4,
      nfs_v4_idmap_domain => $nfs_v4_idmap_domain,
    }
  }

  if ($mountd_port != undef){
    file_line { 'rpc-mount-options':
      ensure  => present,
      path    => '/etc/default/nfs-kernel-server',
      line    => "RPCMOUNTDOPTS=--manage-gids --port ${mountd_port} --num-threads ${mountd_threads}",
      match   => '^#?RPCMOUNTDOPTS',
      require => Package['nfs-kernel-server'];
    }

    if $service_manage {
      File_line['rpc-mount-options'] ~> Service['nfs-kernel-server']
    }
  }

  include nfs::server::ubuntu::install, nfs::server::ubuntu::service
}
