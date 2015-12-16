name 'coopr-provisioner'
default_version 'release/0.9.9'

dependency 'ruby'
dependency 'rubygems'
dependency 'bundler'

source :git => 'git://github.com/caskdata/coopr-provisioner.git'
# relative_path 'coopr-provisioner'

build do
  gem 'install fog --no-rdoc --no-ri --version 1.36.0'
  gem 'install sinatra --no-rdoc --no-ri --version 1.4.5'
  gem 'install thin --no-rdoc --no-ri --version 1.6.2'
  gem 'install rest_client --no-rdoc --no-ri --version 1.7.3'
  gem 'install google-api-client --no-rdoc --no-ri --version 0.7.1'
  gem 'install deep_merge --no-rdoc --no-ri --version 1.0.1'
  mkdir install_dir
  copy "#{project_dir}/*", "#{install_dir}"
  command "chmod +x #{install_dir}/bin/*"
  command "find #{install_dir} -type f -name .gitkeep | xargs rm -f"
  gem 'uninstall -Ix rdoc'
end
