name 'coopr-ui'
default_version 'develop'

dependency 'nodejs'

source :git => 'git://github.com/cdapio/coopr.git'
relative_path 'coopr-ui'

npm = "#{install_dir}/embedded/bin/npm"
node = "#{install_dir}/embedded/bin/node"

build do
  mkdir "#{install_dir}/bin"
  copy "#{project_dir}/coopr-ui/bin/*", "#{install_dir}/bin"
  copy '/var/cache/omnibus/src/node-v0.10.26/LICENSE', "#{install_dir}/LICENSE.node"
  command "chmod +x #{install_dir}/bin/*"

  command "cd #{project_dir}/coopr-ui; #{npm} install bower"
  command "cd #{project_dir}/coopr-ui; #{npm} install"
  command "cd #{project_dir}/coopr-ui; #{node} #{project_dir}/coopr-ui/node_modules/bower/bin/bower install --config.interactive=false"
  command "cd #{project_dir}/coopr-ui; #{node} #{project_dir}/coopr-ui/node_modules/gulp/bin/gulp.js clean"
  command "cd #{project_dir}/coopr-ui; #{node} #{project_dir}/coopr-ui/node_modules/gulp/bin/gulp.js distribute"

  copy "#{project_dir}/coopr-ui/dist*", install_dir
  copy "#{project_dir}/coopr-ui/server*", install_dir
  copy "#{project_dir}/coopr-ui/package.json", install_dir

  command "cd #{install_dir}; #{npm} install --production"

  command "find #{install_dir} -type f -name .gitkeep | xargs rm -f"
end
