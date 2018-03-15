# Installs the Jenkins package
class jenkins::install {

  $java_path = '/usr/lib/jvm/jre-1.8.0'

  class { 'java':
    distribution => 'jre',
  }

  if $jenkins::use_reserved_ports {
    ldconfig::entry { 'java':
      paths   => [
        "${java_path}/lib/amd64/jli",
        "${java_path}/lib/i386/jli",
      ],
      require => [
        Class['java'],
      ]
    }

    # http://man7.org/linux/man-pages/man7/capabilities.7.html
    file_capability { "${java_path}/bin/java":
      ensure     => present,
      capability => [
        'cap_net_bind_service=epi',
      ],
      require    => [
        Ldconfig::Entry['java'],
      ],
    }
  }

  yumrepo { 'jenkins':
    ensure   => 'present',
    baseurl  => 'http://pkg.jenkins.io/redhat',
    descr    => 'Jenkins',
    gpgkey   => 'https://pkg.jenkins.io/redhat/jenkins.io.key',
    gpgcheck => '1',
  }

  package { 'jenkins':
    ensure  => $jenkins::version,
    require => [
      Yumrepo['jenkins'],
    ],
  }

}
