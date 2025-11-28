class xalon {

  # Install required packages
  package { ['nginx', 'git']:
    ensure => installed,
  }

  # Create deployment directory
  file { '/var/www/xalon':
    ensure  => directory,
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0755',
  }

  # Clone or update GitHub repo
  vcsrepo { '/var/www/xalon':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/NITESH7KUMAR/Xalon',
    revision => 'main',
    owner    => 'www-data',
    group    => 'www-data',
    require  => Package['git'],
  }

  # Configure Nginx site
  file { '/etc/nginx/sites-available/xalon':
    ensure  => file,
    content => template('xalon/nginx.conf.erb'),
    require => Package['nginx'],
  }

  # Enable Nginx site
  file { '/etc/nginx/sites-enabled/xalon':
    ensure  => link,
    target  => '/etc/nginx/sites-available/xalon',
    require => File['/etc/nginx/sites-available/xalon'],
  }

  # Remove default Nginx site
  file { '/etc/nginx/sites-enabled/default':
    ensure  => absent,
    require => Package['nginx'],
  }

  # Ensure Nginx service is running
  service { 'nginx':
    ensure  => running,
    enable  => true,
    require => File['/etc/nginx/sites-enabled/xalon'],
  }

  # Optional SSL installation and certificate only if domain_real is set
  if $::domain_real {
    package { ['certbot', 'python3-certbot-nginx']:
      ensure => installed,
      before => Exec['certbot-xalon'],
    }

    exec { 'certbot-xalon':
      command => "/usr/bin/certbot --nginx -d ${::domain_real} --non-interactive --agree-tos -m your-email@example.com",
      unless  => "/usr/bin/test -f /etc/letsencrypt/live/${::domain_real}/fullchain.pem",
      path    => ['/usr/bin', '/bin'],
      require => Service['nginx'],
    }
  }
}

