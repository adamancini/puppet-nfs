class nfs::server::debian::install {

  package { 'nfs-kernel-server':
    ensure => $::nfs::server::package_ensure
  }

}
