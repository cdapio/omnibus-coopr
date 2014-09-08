name 'loom-server'
default_version 'develop'

source :git => 'git://github.com/continuuity/loom.git'
relative_path 'server'

build do
  mkdir "#{install_dir}/bin"
  copy "#{project_dir}/bin/*", "#{install_dir}/bin"
  command "cp -fpPR docs/licenses config #{install_dir}"
  mkdir "#{install_dir}/etc/logrotate.d"
  copy "#{project_dir}/distribution/etc/logrotate.d/loom-server", "#{install_dir}/etc/logrotate.d"
  mkdir "#{install_dir}/conf"
  copy "#{project_dir}/distribution/etc/loom/conf.dist/*", "#{install_dir}/conf"
  # command "sed -e 's/APP_NAME/loom-server/g' -e 's/SVC_NAME/server/g' bin/loom-service > #{install_dir}/server/bin/init-loom-server"
  command "chmod +x #{install_dir}/bin/*"
  mkdir "#{install_dir}/lib"
  command 'PATH=/usr/local/maven-3.1.1/bin:$PATH mvn clean package assembly:single -DskipTests=true'
  copy "target/loom-*jar-with-dependencies.jar", "#{install_dir}/lib"
  command "find #{install_dir} -type f -name .gitkeep | xargs rm -f"
end
