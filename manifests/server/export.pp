define nfs::server::export (
  $v3_export_name = $name,
  # Grab the final directory name in the given path and make it our default nfsv4 export name.
  $v4_export_name = regsubst($name, '.*/([^/]+)/?$', '\1'),
  $clients        = 'localhost(ro)',
  $bind           = 'rbind',
  $owner          = 'root',
  $group          = 'root',
  $perms          = '0755',
  # globals for this share
  # propogated to storeconfigs
  $ensure         = 'mounted',
  $mount          = undef,
  $remounts       = false,
  $atboot         = false,
  $options        = '_netdev',
  $bindmount      = undef,
  $nfstag         = undef,
  $server         = $::clientcert) {
  if $nfs::server::nfs_v4 {
    nfs::server::export::nfs_v4::bindmount { $name:
      ensure         => $ensure,
      v4_export_name => $v4_export_name,
      bind           => $bind,
      owner          => $owner,
      group          => $group,
      perms          => $perms,
    }

    nfs::server::export::configure { "${nfs::server::nfs_v4_export_root}/${v4_export_name}":
      ensure  => $ensure,
      clients => $clients,
      require => Nfs::Server::Export::Nfs_v4::Bindmount[$name]
    }

    @@nfs::client::mount { "shared ${v4_export_name} by ${::clientcert}":
      ensure    => $ensure,
      mount     => $mount,
      remounts  => $remounts,
      atboot    => $atboot,
      options   => $options,
      bindmount => $bindmount,
      nfstag    => $nfstag,
      share     => $v4_export_name,
      server    => $server,
    }

  } else {
    nfs::server::export::configure { $v3_export_name:
      ensure  => $ensure,
      clients => $clients,
    }

    if $mount == undef {
      $_mount = $v3_export_name
    } else {
      $_mount = $mount
    }

    @@nfs::client::mount { "shared ${v3_export_name} by ${::clientcert}":
      ensure   => $ensure,
      mount    => $_mount,
      remounts => $remounts,
      atboot   => $atboot,
      options  => $options,
      nfstag   => $nfstag,
      share    => $v3_export_name,
      server   => $server,
      owner    => $owner,
      group    => $group,
      perm     => $perms
    }
  }
}
