name 'coopr-cli'
default_version 'develop'

source :git => 'git://github.com/caskdata/coopr.git'
relative_path 'coopr-cli'

build do
  mkdir "#{install_dir}/bin"
  mkdir "#{install_dir}/lib"
  command 'PATH=/usr/local/maven-3.1.1/bin:$PATH mvn clean package -DskipTests -pl coopr-cli -am'
  %w[javadoc sources tests].each do |jar|
    command "rm -f #{project_dir}/coopr-cli/target/coopr-cli-*-#{jar}.jar"
  end
  copy "#{project_dir}/coopr-cli/target/coopr-cli-*.jar", "#{install_dir}/lib"
  copy "#{project_dir}/coopr-cli/target/bin/*.sh", "#{install_dir}/bin"
  command "chmod +x #{install_dir}/bin/*"
  link "#{install_dir}/bin/coopr-cli.sh", "#{install_dir}/bin/coopr"
  command "rm -rf #{install_dir}/embedded"
  command "find #{install_dir} -type f -name .gitkeep | xargs rm -f"
end
