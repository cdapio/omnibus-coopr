name 'loom-server'
default_version 'develop'

source :git => 'git://github.com/continuuity/loom.git'
relative_path 'server'

build do
  mkdir "#{install_dir}/server/bin"
  copy "bin/loom-server.sh #{install_dir}/server/bin"
  copy "bin/loom-0.9.7-upgrade.rb #{install_dir}/server/bin"
  command "cp -fpPR docs/licenses config #{install_dir}/server"
  mkdir "#{install_dir}/server/etc/logrotate.d"
  copy "server/distribution/etc/logrotate.d/loom-server #{install_dir}/server/etc/logrotate.d"
  mkdir "#{install_dir}/server/conf"
  copy "server/distribution/etc/loom/conf.dist/* #{install_dir}/server/conf"
  command "sed -e 's/APP_NAME/loom-server/g' -e 's/SVC_NAME/server/g' bin/loom-service > #{install_dir}/server/bin/init-loom-server"
  command "chmod +x #{install_dir}/server/bin/*"
  mkdir "#{install_dir}/server/lib"
  command 'cd server && PATH=/usr/local/maven-3.1.1/bin:$PATH mvn clean package assembly:single -DskipTests=true'
  copy "server/target/loom-*jar-with-dependencies.jar #{install_dir}/server/lib"
  command "find #{install_dir} -type f -name .gitkeep | xargs rm -f"
end
