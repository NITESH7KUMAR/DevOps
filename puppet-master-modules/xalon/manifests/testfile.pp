class xalon::testfile {

  # Create a test directory
  file { '/tmp/puppet_test':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  # Create a test file
  file { '/tmp/puppet_test/hello.txt':
    ensure  => file,
    content => "Hello2 from Puppet Master!\n",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File['/tmp/puppet_test'],
  }

}
