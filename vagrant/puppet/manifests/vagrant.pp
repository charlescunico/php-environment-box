class vagrant {
  group { 'puppet':
    ensure => present,
  }


  exec { 'yum-update':
    command => 'yum -y update',
    path    => '/usr/bin'
  }


  package { 'httpd':
    ensure => present,
  }

  package { 'php':
    ensure => present,
  }

  package { 'ruby':
    ensure => present,
  }

  package { 'rubygems':
    ensure => present,
  }

  package { 'nodejs':
    ensure => present,
  }

  package { 'npm':
    ensure => present,
  }

  package { 'libmemcached':
    ensure => present,
  }

  package { 'memcached':
    ensure => present,
  }

  package { 'libgearman':
    ensure => present,
  }

  package { 'gearmand':
    ensure => present,
  }

  package { 'ImageMagick':
    ensure => present,
  }

  package { 'libssh2':
    ensure => present,
  }

  package { 'vim-enhanced':
    ensure => present,
  }

  package { 'git':
    ensure => present,
  }

  package { 'subversion':
    ensure => present,
  }

  package { 'mercurial':
    ensure => present,
  }


  package { 'php-cli':
    ensure => present,
  }

  package { 'php-intl':
    ensure => present,
  }

  package { 'php-mcrypt':
    ensure => present,
  }

  package { 'php-bcmath':
    ensure => present,
  }

  package { 'php-gd':
    ensure => present,
  }

  package { 'php-gmp':
    ensure => present,
  }

  package { 'php-ldap':
    ensure => present,
  }

  package { 'php-mbstring':
    ensure => present,
  }

  package { 'php-soap':
    ensure => present,
  }

  package { 'php-phpunit-PHPUnit':
    ensure => present,
  }

  package { 'php-pgsql':
    ensure => present,
  }

  package { 'php-oci8':
    ensure => present,
  }


  package { 'php-pecl-gearman':
    ensure => present,
  }

  package { 'php-pecl-igbinary':
    ensure => present,
  }

  package { 'php-pecl-imagick':
    ensure => present,
  }

  package { 'php-pecl-memcache':
    ensure => present,
  }

  package { 'php-pecl-memcached':
    ensure => present,
  }

  package { 'php-pecl-ssh2':
    ensure => present,
  }

  package { 'php-pecl-xdebug':
    ensure => present,
  }

  package { 'php-pecl-zendopcache':
    ensure => present,
  }


  package { 'sass':
    ensure   => present,
    provider => 'gem',
    require  => Package['rubygems'],
  }


  service { 'httpd':
    ensure => running,
    enable => true,
  }

  service { 'memcached':
    ensure => running,
    enable => true,
  }

  service { 'gearmand':
    ensure => running,
    enable => true,
  }
}

include vagrant
