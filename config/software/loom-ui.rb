name "loom-ui"
default_version "develop"

dependency "nodejs"

source :git => "git://github.com/continuuity/loom.git"
relative_path 'ui'

build do
  command "mkdir -p #{install_dir}/ui/bin"
  command "cp -fpPR bin/loom-ui.sh #{install_dir}/ui/bin"
  command "mkdir -p #{install_dir}/ui/etc/logrotate.d"
  command "cp -f /var/cache/omnibus/src/node*/LICENSE #{install_dir}/ui/LICENSE.node"
  command "cp -f distribution/etc/logrotate.d/loom-ui #{install_dir}/ui/etc/logrotate.d"
  command "sed -e 's/APP_NAME/loom-ui/g' -e 's/SVC_NAME/ui/g' bin/loom-service > #{install_dir}/ui/bin/init-loom-ui"
  command "cd ui && #{install_dir}/embedded/bin/node tools/r.js -o tools/build.js"
  command "rm -rf ui/omnibus ui/build*"

  command "cp -fpPR ui #{install_dir}"

#  command "cp -pPR * #{install_dir}"
end
