# == Class masterless::service
#
# This class is meant to be called from masterless.
# It ensure the service is running.
#
class masterless::service {

  service { $::masterless::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
