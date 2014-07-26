class mysql {

  package { ['mysql-server']:
    ensure => present,
    require => Exec['apt-get update'],
  }

  service { 'mysql':
    ensure  => running,
    require => Package['mysql-server'],
  }

  file { '/etc/mysql/my.cnf':
    source  => 'puppet:///modules/mysql/my.cnf',
    require => Package['mysql-server'],
    notify  => Service['mysql'],
  }

  exec { 'set-mysql-password':
    unless  => 'mysqladmin -uroot -prootpwd status',
    command => 'mysqladmin -uroot password rootpwd',
    path    => ['/bin', '/usr/bin'],
    require => Service['mysql'], 
  }
}
