name 'loom-provisioner'
default_version 'develop'

dependency 'ruby'
dependency 'rubygems'
dependency 'bundler'
dependency 'zlib'
dependency 'libxml2'
dependency 'libxslt'
dependency 'nokogiri'

source :git => 'git://github.com/continuuity/loom.git'
relative_path 'provisioner'

build do
  gem 'install knife-joyent --no-rdoc --no-ri --version 0.4.8'
  gem 'install knife-rackspace --no-rdoc --no-ri --version 0.9.1'
  gem 'install knife-openstack --no-rdoc --no-ri --version 0.8.1'
  command "mkdir -p #{install_dir}/provisioner/bin"
  command "sed -e 's:provisioner/embedded/bin:embedded/bin:g' bin/loom-provisioner.sh > #{install_dir}/provisioner/bin/loom-provisioner.sh"
  command "cp -fpPR provisioner #{install_dir}"
  command "sed -e 's/APP_NAME/loom-provisioner/g' -e 's/SVC_NAME/provisioner/g' bin/loom-service > #{install_dir}/provisioner/bin/init-loom-provisioner"
  command "chmod +x #{install_dir}/provisioner/bin/*"
  command "mkdir -p #{install_dir}/provisioner/etc/logrotate.d"
  command "cp -f distribution/etc/logrotate.d/loom-provisioner #{install_dir}/provisioner/etc/logrotate.d"
  command "find #{install_dir} -type f -name .gitkeep | xargs rm -f"
  # Joyent ships with bad permissions, allow everyone to read everything
  command "chmod ugo+r #{install_dir}/embedded"
  gem 'uninstall fog -v1.20.0'
  gem 'uninstall nokogiri -v1.6.1'
  gem 'uninstall -Ix rdoc'
end
