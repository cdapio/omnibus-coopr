name 'coopr-ngui'
default_version 'feature/refactor-l2c'

dependency 'nodejs'

source :git => 'git://github.com/continuuity/loom.git'
relative_path 'coopr-ngui'

npm = "#{install_dir}/embedded/bin/npm"
node = "#{install_dir}/embedded/bin/node"

build do
  mkdir "#{install_dir}/bin"
  copy "#{project_dir}/coopr-ngui/bin/*", "#{install_dir}/bin"
  copy '/var/cache/omnibus/src/node-v0.10.26/LICENSE', "#{install_dir}/LICENSE.node"
  command "chmod +x #{install_dir}/bin/*"

  command "cd #{project_dir}/coopr-ngui; #{npm} install bower"
  command "cd #{project_dir}/coopr-ngui; #{npm} install"
  command "cd #{project_dir}/coopr-ngui; #{node} #{project_dir}/coopr-ngui/node_modules/bower/bin/bower install --config.interactive=false"
  command "cd #{project_dir}/coopr-ngui; #{node} #{project_dir}/coopr-ngui/node_modules/gulp/bin/gulp.js build minify"

  copy "#{project_dir}/coopr-ngui/dist*", "#{install_dir}"
  copy "#{project_dir}/coopr-ngui/server.js", "#{install_dir}"
  copy "#{project_dir}/coopr-ngui/package.json", "#{install_dir}"

  command "cd #{install_dir}; #{npm} install --production"

  command "find #{install_dir} -type f -name .gitkeep | xargs rm -f"
end
