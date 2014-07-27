exec { 'apt-get update':
  path => '/usr/bin',
}

exec { 'locale-gen pt_BR.UTF-8':
  path => '/usr/bin',
}

package { 'vim':
  ensure => present,
}

file { '/var/www/':
  ensure => 'directory',
}

include nginx, php, mysql
