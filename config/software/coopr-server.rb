name 'coopr-server'
default_version 'develop'

source :git => 'git://github.com/caskdata/coopr.git'
relative_path 'coopr-server'

build do
  mkdir "#{install_dir}/bin"
  mkdir "#{install_dir}/templates"
  command 'git submodule init && git submodule update'
  copy "#{project_dir}/coopr-server/bin/*", "#{install_dir}/bin"
  copy "#{project_dir}/coopr-docs/licenses", install_dir
  copy "#{project_dir}/coopr-server/distribution", install_dir
  copy "#{project_dir}/coopr-server/sql", install_dir
  %w[bin clustertemplates hardwaretypes imagetypes providers services].each do |dir|
    copy "#{project_dir}/coopr-templates/#{dir}", "#{install_dir}/templates"
  end
  copy "#{project_dir}/coopr-server/templates/*", "#{install_dir}/templates"
  mkdir "#{install_dir}/conf"
  copy "#{project_dir}/coopr-server/distribution/etc/coopr/conf.dist/*", "#{install_dir}/conf"
  command "chmod +x #{install_dir}/bin/*"
  mkdir "#{install_dir}/lib"
  command 'cd coopr-server; PATH=/usr/local/maven-3.1.1/bin:$PATH mvn clean package assembly:single -DskipTests=true'
  copy "#{project_dir}/coopr-server/target/coopr-*jar-with-dependencies.jar", "#{install_dir}/lib"
  command "find #{install_dir} -type f -name .gitkeep | xargs rm -f"
end
