name 'coopr-ui'
default_version 'feature/refactor-l2c'

dependency 'nodejs'

source :git => 'git://github.com/continuuity/loom.git'
relative_path 'ui'

build do
  mkdir "#{install_dir}/bin"
  copy "#{project_dir}/ui/bin/*", "#{install_dir}/bin"
  mkdir "#{install_dir}/etc/logrotate.d"
  copy '/var/cache/omnibus/src/node-v0.10.26/LICENSE', "#{install_dir}/LICENSE.node"
  copy "#{project_dir}/ui/distribution/etc/logrotate.d/*", "#{install_dir}/etc/logrotate.d"
  command "chmod +x #{install_dir}/bin/*"
  command "cd ui; #{install_dir}/embedded/bin/node tools/r.js -o tools/build.js"
  delete "#{project_dir}/ui/omnibus"
  delete "#{project_dir}/ui/build*"
  copy "#{project_dir}/ui/*", "#{install_dir}"
  command "find #{install_dir} -type f -name .gitkeep | xargs rm -f"
end
