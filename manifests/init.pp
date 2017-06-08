# Class: web2day-demo
class demo {

  $os_family = $::facts['os']['family']

  case $os_family {
    'RedHat': {
      $apache_name = 'httpd'
    }
    'Debian': {
      $apache_name = 'apache2'

    }
    default: {
      fail("Unsupported operatingsystem: ${os_family}")
    }
  }

  package { $apache_name:
    ensure => present,
  }

  service { $apache_name:
    ensure => running,
  }

  file { '/var/www/html/web2day.html':
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template("${module_name}/web2day.html.erb"),
  }

  firewall { '102 allow http access for Apache':
    dport  => [80],
    proto  => 'tcp',
    action => 'accept',
  }

}
