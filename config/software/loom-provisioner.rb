name project
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
  command "cp -fpPR provisioner #{install_dir}"
  command "sed -e 's/APP_NAME/#{project}/g' -e 's/SVC_NAME/provisioner/g' bin/loom-service > #{install_dir}/provisioner/bin/init-#{project}"
  command "chmod +x #{install_dir}/provisioner/bin/*"
  mkdir "#{install_dir}/provisioner/etc/logrotate.d"
  copy "#{project_dir}/provisioner/distribution/etc/logrotate.d/#{project}", "#{install_dir}/provisioner/etc/logrotate.d"
  command "find #{install_dir} -type f -name .gitkeep | xargs rm -f"
  gem 'uninstall -Ix rdoc'
end
