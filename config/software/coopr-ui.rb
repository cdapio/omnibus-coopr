name 'coopr-ui'
default_version 'develop'

dependency 'nodejs'

source :git => 'git://github.com/continuuity/loom.git'
relative_path 'ui'

build do
  command "mkdir -p #{install_dir}/ui/bin"
  command "sed -e 's:ui/embedded/bin:embedded/bin:g' bin/ui.sh > #{install_dir}/ui/bin/ui.sh"
  command "mkdir -p #{install_dir}/ui/etc/logrotate.d"
  command "cp -f /var/cache/omnibus/src/node-v0.10.26/LICENSE #{install_dir}/ui/LICENSE.node"
  command "cp -f ui/distribution/etc/logrotate.d/coopr-ui #{install_dir}/ui/etc/logrotate.d"
  command "sed -e 's/APP_NAME/coopr-ui/g' -e 's/SVC_NAME/ui/g' bin/coopr-service > #{install_dir}/ui/bin/init-coopr-ui"
  command "chmod +x #{install_dir}/ui/bin/*"
  command "cd ui && #{install_dir}/embedded/bin/node tools/r.js -o tools/build.js"
  command 'rm -rf ui/omnibus ui/build*'
  command "cp -fpPR ui #{install_dir}"
  command "find #{install_dir} -type f -name .gitkeep | xargs rm -f"
end
