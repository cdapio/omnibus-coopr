name 'loom-ui'
default_version 'develop'

dependency 'nodejs'

source :git => 'git://github.com/continuuity/loom.git'
relative_path 'ui'

build do
  mkdir "#{install_dir}/ui/bin"
  command "sed -e 's:ui/embedded/bin:embedded/bin:g' bin/loom-ui.sh > #{install_dir}/ui/bin/loom-ui.sh"
  mkdir "#{install_dir}/ui/etc/logrotate.d"
  copy "/var/cache/omnibus/src/node-v0.10.26/LICENSE #{install_dir}/ui/LICENSE.node"
  copy "ui/distribution/etc/logrotate.d/loom-ui #{install_dir}/ui/etc/logrotate.d"
  command "sed -e 's/APP_NAME/loom-ui/g' -e 's/SVC_NAME/ui/g' bin/loom-service > #{install_dir}/ui/bin/init-loom-ui"
  command "chmod +x #{install_dir}/ui/bin/*"
  command "cd ui && #{install_dir}/embedded/bin/node tools/r.js -o tools/build.js"
  delete 'ui/omnibus ui/build*'
  command "cp -fpPR ui #{install_dir}"
  command "find #{install_dir} -type f -name .gitkeep | xargs rm -f"
end
