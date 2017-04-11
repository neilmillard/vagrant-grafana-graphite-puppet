class profile::apache{
  include ::apache

  $my_vhosts = hiera(profile::apache::my_vhosts,[])
  create_resources('apache_vhost',$my_vhosts)

}