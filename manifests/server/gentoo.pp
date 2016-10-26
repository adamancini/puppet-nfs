# Gentoo specifix stuff
class nfs::server::gentoo(
  $nfs_v4 = false,
  $nfs_v4_idmap_domain = undef,
  $mountd_port         = undef,
  $mountd_threads      = undef,
  $service_manage      = true,
) {

  if !defined(Class['nfs::client::gentoo']) {
    class{ 'nfs::client::gentoo':
      nfs_v4              => $nfs_v4,
      nfs_v4_idmap_domain => $nfs_v4_idmap_domain,
    }
  }

  if ($mountd_port != undef){
    fail('setting the mountd port currently not supported on Gentoo')
  }

  if ($mountd_threads != undef){
    fail('setting the mountd thread number currently not supported on Gentoo')
  }

  include nfs::server::gentoo::install, nfs::server::gentoo::service

}
