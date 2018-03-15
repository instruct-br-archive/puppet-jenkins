# Installs the Jenkins package
class jenkins::install {

  class { 'java':
    distribution => 'jre',
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
