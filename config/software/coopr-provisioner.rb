name 'coopr-provisioner'
default_version 'develop'

dependency 'ruby'
dependency 'rubygems'
dependency 'bundler'

source :git => 'git://github.com/caskdata/coopr-provisioner.git'
# relative_path 'coopr-provisioner'

build do
  bundle 'install --jobs 7 --without test'
  mkdir install_dir
  copy "#{project_dir}/*", install_dir
  command "chmod +x #{install_dir}/bin/*"
  command "find #{install_dir} -type f -name .gitkeep | xargs rm -f"
  gem 'uninstall -Ix rdoc'
end
