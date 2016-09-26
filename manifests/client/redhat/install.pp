# Shamefully stolen from https://github.com/frimik/puppet-nfs
# refactored a bit

class nfs::client::redhat::install {

  Package {
    before => Class['nfs::client::redhat::configure']
  }
  package { 'nfs-utils':
    ensure => $::nfs::client::package_ensure,
  }

  if $::nfs::client::redhat::params::osmajor == 6 or $::nfs::client::redhat::params::osmajor == 7 {
    package {'rpcbind':
      ensure => $::nfs::client::package_ensure,
    }
  } elsif $::nfs::client::redhat::params::osmajor == 5 {
    package { 'portmap':
      ensure => $::nfs::client::package_ensure,
    }
  }
}
