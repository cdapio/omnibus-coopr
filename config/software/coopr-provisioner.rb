name 'coopr-provisioner'
default_version 'develop'

dependency 'ruby'
dependency 'rubygems'
dependency 'bundler'

source :git => 'git://github.com/continuuity/loom.git'
relative_path 'provisioner'

build do
  gem 'install fog --no-rdoc --no-ri --version 1.21.0'
  gem 'install sinatra --no-rdoc --no-ri --version 1.4.5'
  gem 'install thin --no-rdoc --no-ri --version 1.6.2'
  gem 'install rest_client --no-rdoc --no-ri --version 1.7.3'
  command "mkdir -p #{install_dir}/provisioner/bin"
  command "sed -e 's:provisioner/embedded/bin:embedded/bin:g' bin/provisioner.sh > #{install_dir}/provisioner/bin/provisioner.sh"
  command "cp -fpPR provisioner #{install_dir}"
  command "sed -e 's/APP_NAME/coopr-provisioner/g' -e 's/SVC_NAME/provisioner/g' bin/coopr-service > #{install_dir}/provisioner/bin/init-coopr-provisioner"
  command "chmod +x #{install_dir}/provisioner/bin/*"
  command "mkdir -p #{install_dir}/provisioner/etc/logrotate.d"
  command "cp -f provisioner/distribution/etc/logrotate.d/coopr-provisioner #{install_dir}/provisioner/etc/logrotate.d"
  command "find #{install_dir} -type f -name .gitkeep | xargs rm -f"
  # Joyent ships with bad permissions, allow everyone to read everything
  command "chmod ugo+r #{install_dir}/embedded"
  gem 'uninstall -Ix rdoc'
end
