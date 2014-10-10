name 'coopr-ui'
default_version 'develop'

dependency 'nodejs'

source :git => 'git://github.com/caskdata/coopr.git'
relative_path 'coopr-ui'

build do
  mkdir "#{install_dir}/bin"
  copy "#{project_dir}/coopr-ui/bin/*", "#{install_dir}/bin"
  mkdir "#{install_dir}/etc/logrotate.d"
  copy '/var/cache/omnibus/src/node-v0.10.26/LICENSE', "#{install_dir}/LICENSE.node"
  copy "#{project_dir}/coopr-ui/distribution/etc/logrotate.d/*", "#{install_dir}/etc/logrotate.d"
  command "chmod +x #{install_dir}/bin/*"
  command "cd coopr-ui; #{install_dir}/embedded/bin/node tools/r.js -o tools/build.js"
  delete "#{project_dir}/coopr-ui/omnibus"
  delete "#{project_dir}/coopr-ui/build*"
  copy "#{project_dir}/coopr-ui/*", "#{install_dir}"
  command "find #{install_dir} -type f -name .gitkeep | xargs rm -f"
end
