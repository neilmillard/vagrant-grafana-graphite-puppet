# -*- mode: ruby -*-
# vi: set ft=ruby :

def is_plugin(name)
  if Vagrant.has_plugin?(name)
    puts "using #{name}"
  else
    puts "please run vagrant plugin install #{name}"
    exit(1)
  end
end

Vagrant.configure("2") do |config|
  # https://atlas.hashicorp.com/centos/boxes/7
  config.vm.box = "centos/7"

  # the centos/7 box uses rsync by default, for windows you'll want to disable it
  if Vagrant::Util::Platform.windows?
    config.vm.synced_folder ".", "/vagrant", disabled: true
  end

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 8081, host: 8081
  config.vm.network "forwarded_port", guest: 2003, host: 2003
  config.vm.network "forwarded_port", guest: 2003, host: 2003, protocol: 'udp'
  config.vm.network "forwarded_port", guest: 2004, host: 2004
  config.vm.network "forwarded_port", guest: 8125, host: 8125, protocol: 'udp'

  config.vm.hostname = "grafana"

  # Required Environment Variables
  if ENV['init_role']
    $init_role = ENV['init_role']
  else
    puts "Environment variable: 'init_role' is not set, defaulting to 'mongodb'"
    $init_role = 'mongodb'
  end

  if ENV['init_env']
    $init_env = ENV['init_env']
  else
    puts "Environment variable: 'init_env' is not set, defaulting to 'dev'"
    $init_env = 'dev'
  end

  # Optional Environment Variables
  if ENV['init_repouser']
    $init_repouser = ENV['init_repouser']
  else
    puts "Environment variable: 'init_repouser' is not set, defaulting to 'neilmillard'"
    $init_repouser = 'neilmillard'
  end

  if ENV['init_reponame']
    $init_reponame = ENV['init_reponame']
  else
    puts "Environment variable: 'init_reponame' is not set, defaulting to 'vagrant-grafana-graphite-puppet'"
    $init_reponame = 'vagrant-grafana-graphite-puppet'
  end

  if ENV['init_repobranch']
    $init_repobranch = ENV['init_repobranch']
  else
    puts "Environment variable: 'init_repobranch' is not set, defaulting to 'master'"
    $init_repobranch = 'master'
  end

  if ENV['init_debug']
    $init_debug = ' --debug'
  else
    $init_debug = ''
  end

  args = "--role #{$init_role} --environment #{$init_env} --repouser #{$init_repouser} --reponame #{$init_reponame} --repobranch #{$init_repobranch} #{$init_debug}"
  config.vm.provision :shell, :path => 'provision.sh', :args => args

end
