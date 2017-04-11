# Nasty ass hax to allow several levels of directories
define nfs::mkdir (
  $owner = 'root',
  $group = 'root',
  $perm  = '0755'
) {
  exec { "mkdir_recurse_${name}":
    path    => ['/bin', '/usr/bin'],
    command => "mkdir -p ${name}",
    returns => [ '0', '1' ],
    unless => "test -d ${name}",
  }

  file { $name:
    ensure  => directory,
    require => Exec["mkdir_recurse_${name}"],
    owner   => $owner,
    group   => $group,
    mode    => $perm,
  }

}
