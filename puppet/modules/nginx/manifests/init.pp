class nginx {
  
  package { 'nginx':
    ensure => 'present',
    require => Exec['apt-get update'],
  }

  service { 'nginx':
    ensure => running,
    require => Package['nginx'],
  }

  file { '/etc/nginx/global/':
    ensure => 'directory',
  }

  file { 'nginx-conf':
    path => '/etc/nginx/nginx.conf',
    ensure => file,
    require => Package['nginx'],
    source  => 'puppet:///modules/nginx/nginx.conf',
  }

  file { 'common-conf':
    path => '/etc/nginx/global/common.conf',
    ensure => file,
    require => Package['nginx'],
    source  => 'puppet:///modules/nginx/common.conf',
  }

  file { 'cakephp-conf':
    path => '/etc/nginx/global/cakephp.conf',
    ensure => file,
    require => Package['nginx'],
    source  => 'puppet:///modules/nginx/cakephp.conf',
  }

  file { 'php-conf':
    path => '/etc/nginx/global/php.conf',
    ensure => file,
    require => Package['nginx'],
    source  => 'puppet:///modules/nginx/php.conf',
  }
  
  file { 'default-nginx-disable':
      path => '/etc/nginx/sites-enabled/default',
      ensure => absent,
      require => Package['nginx'],
  }
}
