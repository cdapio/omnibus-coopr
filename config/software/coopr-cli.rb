name 'coopr-cli'
default_version 'develop'

source :git => 'git://github.com/caskdata/coopr.git'
relative_path 'coopr-cli'

build do
  mkdir "#{install_dir}/bin"
  copy "#{project_dir}/coopr-cli/bin/*.sh", "#{install_dir}/bin"
  command "chmod +x #{install_dir}/bin/*"
  mkdir "#{install_dir}/lib"
  command 'cd coopr-cli; PATH=/usr/local/maven-3.1.1/bin:$PATH mvn clean package -DskipTests -pl coopr-cli -am'
  %w(javadoc sources test).each do |jar|
    command "rm -f #{project_dir}/coopr-cli/target/coopr-cli-*-#{jar}.jar"
  end
  copy "#{project_dir}/coopr-cli/target/coopr-cli-*.jar", "#{install_dir}/lib"
  command "find #{install_dir} -type f -name .gitkeep | xargs rm -f"
end
