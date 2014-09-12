# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'vagrant'

if Vagrant::VERSION < '1.2.1'
  raise 'The Omnibus Build Lab is only compatible with Vagrant 1.2.1+'
end

host_project_path = File.expand_path('..', __FILE__)
guest_project_path = "/home/vagrant/#{File.basename(host_project_path)}"
master_project = 'coopr'

project_names = ENV['COOPR_BUILD_PROJECTS'].split if ENV['COOPR_BUILD_PROJECTS']
project_names = %w(coopr-provisioner coopr-server coopr-ui coopr-standalone) if project_names.nil?

Vagrant.configure('2') do |config|

  config.vm.hostname = "#{master_project}-omnibus-build-lab"

  %w{
    ubuntu-12.04
    centos-6.5
  }.each do |platform|

    config.vm.define platform do |c|
      c.vm.box = "opscode-#{platform}"
      c.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_#{platform}_chef-provisionerless.box"
    end

  end

  config.vm.provider :virtualbox do |vb|
    # Give enough horsepower to build without taking all day.
    vb.customize [
      'modifyvm', :id,
      '--memory', '4096',
      '--cpus', '4'
    ]
  end

  # Ensure a recent version of the Chef Omnibus packages are installed
  config.omnibus.chef_version = :latest

  # Enable the berkshelf-vagrant plugin
  config.berkshelf.enabled = true
  config.ssh.forward_agent = true

  host_project_path = File.expand_path('..', __FILE__)
  guest_project_path = "/home/vagrant/#{File.basename(host_project_path)}"

  config.vm.synced_folder host_project_path, guest_project_path

  project_names.each do |project_name|

    # Update APT
    config.vm.provision :shell, :inline => <<-DO_APT
      test -x /usr/bin/apt-get && sudo apt-get update || true
    DO_APT

    # prepare VM to be an Omnibus builder
    config.vm.provision :chef_solo do |chef|
      chef.json = {
        'omnibus' => {
          'build_user' => 'vagrant',
          'build_dir' => guest_project_path,
          'install_dir' => "/opt/coopr"
        }
      }

      chef.run_list = [
        'recipe[omnibus::default]',
        'recipe[java::default]',
        'recipe[maven::default]'
      ]
    end

    config.vm.provision :shell, :inline => <<-OMNIBUS_BUILD
      export PATH=/usr/local/bin:/usr/local/maven-3.1.1/bin:$PATH
      cd #{guest_project_path}
      gem install bundler
      su vagrant -c "bundle install --binstubs"
      su vagrant -c "bin/omnibus build #{project_name}"
      rm -rf /opt/coopr
    OMNIBUS_BUILD

  end
end
