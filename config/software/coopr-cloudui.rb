name 'coopr-cloudui'
default_version 'develop'

dependency 'nodejs'

source :git => 'git://github.com/caskdata/coopr-cloud.git'
relative_path 'coopr-cloudui'

npm = "#{install_dir}/embedded/bin/npm"
node = "#{install_dir}/embedded/bin/node"

build do
  mkdir "#{install_dir}/bin"
  copy "#{project_dir}/coopr-cloudui/bin/*", "#{install_dir}/bin"
  copy '/var/cache/omnibus/src/node-v0.10.26/LICENSE', "#{install_dir}/LICENSE.node"
  command "chmod +x #{install_dir}/bin/*"

  command "cd #{project_dir}/coopr-cloudui; #{npm} install"
  command "cd #{project_dir}/coopr-cloudui; #{node} #{project_dir}/coopr-cloudui/node_modules/gulp/bin/gulp.js distribute"

  copy "#{project_dir}/coopr-cloudui/dist*", "#{install_dir}"
  copy "#{project_dir}/coopr-cloudui/server/server.js", "#{install_dir}"
  copy "#{project_dir}/coopr-cloudui/package.json", "#{install_dir}"

  command "cd #{install_dir}; #{npm} install --production"

  command "find #{install_dir} -type f -name .gitkeep | xargs rm -f"
end
