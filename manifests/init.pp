# == Class: masterless
#
# Full description of class masterless here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class masterless (
  $package_name = $::masterless::params::package_name,
  $service_name = $::masterless::params::service_name,
) inherits ::masterless::params {

  # validate parameters here

  class { '::masterless::install': } ->
  class { '::masterless::config': } ~>
  class { '::masterless::service': } ->
  Class['::masterless']
}
