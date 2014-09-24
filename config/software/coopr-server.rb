name 'coopr-server'
default_version 'feature/refactor-l2c'

source :git => 'git://github.com/continuuity/loom.git'
relative_path 'coopr-server'

build do
  mkdir "#{install_dir}/bin"
  copy "#{project_dir}/coopr-server/bin/*", "#{install_dir}/bin"
  command "cp -fpPR #{project_dir}/docs/licenses #{project_dir}/config #{install_dir}"
  copy "#{project_dir}/coopr-server/distribution", "#{install_dir}"
  mkdir "#{install_dir}/conf"
  copy "#{project_dir}/coopr-server/distribution/etc/coopr/conf.dist/*", "#{install_dir}/conf"
  command "chmod +x #{install_dir}/bin/*"
  mkdir "#{install_dir}/lib"
  command 'cd coopr-server; PATH=/usr/local/maven-3.1.1/bin:$PATH mvn clean package assembly:single -DskipTests=true'
  copy "#{project_dir}/coopr-server/target/coopr-*jar-with-dependencies.jar", "#{install_dir}/lib"
  command "find #{install_dir} -type f -name .gitkeep | xargs rm -f"
end
