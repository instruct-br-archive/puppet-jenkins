class jenkins::service {

  $requirements = $jenkins::use_reserved_ports ? {
    true    => Exec['ldconfig::exec'],
    default => undef,
  }

  service { 'jenkins':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => [
      $requirements,
    ]
  }

}
