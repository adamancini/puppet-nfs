class nfs::server::redhat::install {

  package { 'nfs4-acl-tools':
    ensure => $::nfs::server::package_ensure,
  }

}
