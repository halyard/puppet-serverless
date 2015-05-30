# == Class masterless::params
#
# This class is meant to be called from masterless.
# It sets variables according to platform.
#
class masterless::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'masterless'
      $service_name = 'masterless'
    }
    'RedHat', 'Amazon': {
      $package_name = 'masterless'
      $service_name = 'masterless'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
