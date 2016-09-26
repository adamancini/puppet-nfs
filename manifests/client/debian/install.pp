class nfs::client::debian::install {

  package { 'rpcbind':
    ensure => $::nfs::client::package_ensure,
  }

  package { ['nfs-common', 'nfs4-acl-tools']:
    ensure => $::nfs::client::package_ensure,
  }

}
