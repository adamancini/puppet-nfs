class nfs::server::ubuntu::install {

  package { 'nfs-kernel-server':
    ensure => $::nfs::server::package_ensure
  }

}
