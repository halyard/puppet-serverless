# == Class masterless::install
#
# This class is called from masterless for install.
#
class masterless::install {

  package { $::masterless::package_name:
    ensure => present,
  }
}
