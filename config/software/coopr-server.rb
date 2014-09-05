name 'coopr-server'
default_version 'develop'

source :git => 'git://github.com/continuuity/loom.git'
relative_path 'server'

build do
  command "mkdir -p #{install_dir}/server/bin"
  command "cp -fpPR bin/server.sh #{install_dir}/server/bin"
  command "cp -fpPR bin/coopr-0.9.7-upgrade.rb #{install_dir}/server/bin"
  command "cp -fpPR docs/licenses config #{install_dir}/server"
  command "mkdir -p #{install_dir}/server/conf #{install_dir}/server/etc/logrotate.d"
  command "cp -f server/distribution/etc/logrotate.d/coopr-server #{install_dir}/server/etc/logrotate.d"
  command "cp -f server/distribution/etc/coopr/conf.dist/* #{install_dir}/server/conf"
  command "sed -e 's/APP_NAME/coopr-server/g' -e 's/SVC_NAME/server/g' bin/coopr-service > #{install_dir}/server/bin/init-coopr-server"
  command "chmod +x #{install_dir}/server/bin/*"
  command "mkdir -p #{install_dir}/server/lib"
  command 'cd server && PATH=/usr/local/maven-3.1.1/bin:$PATH mvn clean package assembly:single -DskipTests=true'
  command "cp -fpPR server/target/coopr-*jar-with-dependencies.jar #{install_dir}/server/lib"
  command "find #{install_dir} -type f -name .gitkeep | xargs rm -f"
end
