# Configures the Jenkins service
class jenkins::config {

  Augeas {
    context => '/files/etc/sysconfig/jenkins',
    notify  => Service['jenkins'],
  }

  augeas { 'jenkins_homedir':
    changes => [ "set JENKINS_HOME '\"${jenkins::homedir}\"'", ],
  }

  if $jenkins::java_cmd {
    augeas { 'jenkins_java_cmd':
      changes => [ "set JENKINS_JAVA_CMD '\"${jenkins::java_cmd}\"'", ],
    }
  }

  augeas { 'jenkins_user':
    changes => [ "set JENKINS_USER '\"${jenkins::user}\"'", ],
  }

  augeas { 'jenkins_java_args':
    changes => [ "set JENKINS_JAVA_OPTIONS '\"${jenkins::java_args}\"'", ],
  }

  $real_http_port = $jenkins::use_reserved_ports ? {
    true    => 80,
    default => $jenkins::http_port,
  }
  augeas { 'jenkins_http_port':
    changes => [ "set JENKINS_PORT '\"${real_http_port}\"'", ],
  }

  augeas { 'jenkins_http_listen_address':
    changes => [ "set JENKINS_LISTEN_ADDRESS '\"${jenkins::http_listen_address}\"'", ],
  }

  if $jenkins::enable_https {
    $real_https_port = $jenkins::use_reserved_ports ? {
      true    => 443,
      default => $jenkins::https_port,
    }
    augeas { 'jenkins_https_port':
      changes => [ "set JENKINS_HTTPS_PORT '\"${real_https_port}\"'", ],
    }
    augeas { 'jenkins_https_keystore':
      changes => [ "set JENKINS_HTTPS_KEYSTORE '\"${jenkins::https_keystore}\"'", ],
    }
    augeas { 'jenkins_https_keystore_password':
      changes => [ "set JENKINS_HTTPS_KEYSTORE_PASSWORD '\"${jenkins::https_keystore_password}\"'", ],
    }
    augeas { 'jenkins_https_listen_address':
      changes => [ "set JENKINS_HTTPS_LISTEN_ADDRESS '\"${jenkins::https_listen_address}\"'", ],
    }
  }

  augeas { 'jenkins_debug_level':
    changes => [ "set JENKINS_DEBUG_LEVEL '\"${jenkins::debug}\"'", ],
  }

  augeas { 'jenkins_enable_access_log':
    changes => [ "set JENKINS_ENABLE_ACCESS_LOG '\"${jenkins::enable_access_log}\"'", ],
  }

  augeas { 'jenkins_handler_max':
    changes => [ "set JENKINS_HANDLER_MAX '\"${jenkins::handler_max}\"'", ],
  }

  augeas { 'jenkins_handler_idle':
    changes => [ "set JENKINS_HANDLER_IDLE '\"${jenkins::handler_idle}\"'", ],
  }

  if $jenkins::args {
    augeas { 'jenkins_args':
      changes => [ "set JENKINS_ARGS '\"${jenkins::args}\"'", ],
    }
  }

}
