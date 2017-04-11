class role::grafana {
  include ::profile::base
  include ::profile::os_limits
  include ::profile::pip
  include selinux

  include ::profile::apache
  include ::profile::graphite
  include ::profile::grafana

}