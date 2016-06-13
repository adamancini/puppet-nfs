class nfs::server::redhat(
  $nfs_v4              = false,
  $nfs_v4_idmap_domain = undef,
  $mountd_port         = undef,
  $mountd_threads      = 1,
  $service_manage      = true,
) {
  if $::operatingsystemmajrelease and $::operatingsystemmajrelease =~ /^7/ {
    $service_name = 'nfs-server'
  } else {
    $service_name = 'nfs'
  }

  if !defined(Class['nfs::client::redhat']) {
    class{ 'nfs::client::redhat':
      nfs_v4              => $nfs_v4,
      nfs_v4_idmap_domain => $nfs_v4_idmap_domain,
    }
  }

  if ($mountd_port != undef){
    file_line { 'rpc-mount-options':
      ensure  => present,
      path    => '/etc/sysconfig/nfs',
      line    => "MOUNTD_PORT=${mountd_port}",
      match   => '^#?MOUNTD_PORT',
      require => Package['nfs-utils'];
    }

    if $service_manage {
      File_line['rpc-mount-options'] ~> Service[$service_name]
    }
  }

  include nfs::server::redhat::install, nfs::server::redhat::service

}
