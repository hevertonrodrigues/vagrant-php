exec { 'apt-get update':
  path => '/usr/bin',
}

package { 'vim':
  ensure => present,
}

file { '/var/www/':
  ensure => 'directory',
}

include nginx, php, mysql

# Adiciona bibliotecas depois de tudo instalado
# exec { 'apt-get install php5-fpm php-apc php5-mcrypt php5-memcached php5-gd php5-curl php5-imagick php5-json php-xml-parser php5-mysqlnd':
#   path => '/usr/bin',
# }