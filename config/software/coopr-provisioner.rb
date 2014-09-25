name 'coopr-provisioner'
default_version 'release/0.9.8'

dependency 'ruby'
dependency 'rubygems'
dependency 'bundler'

source :git => 'git://github.com/continuuity/loom.git'
relative_path 'coopr-provisioner'

build do
  gem 'install fog --no-rdoc --no-ri --version 1.21.0'
  gem 'install sinatra --no-rdoc --no-ri --version 1.4.5'
  gem 'install thin --no-rdoc --no-ri --version 1.6.2'
  gem 'install rest_client --no-rdoc --no-ri --version 1.7.3'
  gem 'install google-api-client --no-rdoc --no-ri --version 0.7.1'
  mkdir install_dir
  copy "#{project_dir}/coopr-provisioner/*", "#{install_dir}"
  command "chmod +x #{install_dir}/bin/*"
  command "find #{install_dir} -type f -name .gitkeep | xargs rm -f"
  gem 'uninstall -Ix rdoc'
end
