class nfs::server::darwin(
  $nfs_v4              = false,
  $nfs_v4_idmap_domain = undef,
  $mountd_port         = undef,
  $mountd_threads      = undef,
  $service_manage      = true,
) {
  fail('NFS server is not supported on Darwin')
}
