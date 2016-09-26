class nfs::client::gentoo::install {

  package { ['net-nds/rpcbind', 'net-fs/nfs-utils', 'net-libs/libnfsidmap']:
    ensure => $::nfs::client::package_ensure,
  }
}
