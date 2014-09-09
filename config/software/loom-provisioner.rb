name 'loom-provisioner'
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
  mkdir install_dir
  copy "#{project_dir}/provisioner/*", "#{install_dir}"
  command "chmod +x #{install_dir}/bin/*"
  command "find #{install_dir} -type f -name .gitkeep | xargs rm -f"
  gem 'uninstall -Ix rdoc'
end
