name 'coopr-standalone'
default_version 'develop'

source :git => 'git://github.com/continuuity/loom.git'
relative_path 'standalone'

build do
  command "mkdir -p #{install_dir}/bin"
  command "cp -fpPR bin/coopr-0.9.7-upgrade.rb #{install_dir}/bin"
  command "sed -e 's#_NODE:-node#_NODE:-/opt/coopr/embedded/bin/node#g' -e 's#_RUBY:-ruby#_RUBY:-/opt/coopr/embedded/bin/ruby#g' standalone/bin/coopr.sh > #{install_dir}/bin/coopr.sh"
  %w(provisioner server ui).each do |c|
    command "ln -sf #{install_dir}/#{c}/bin/#{c}.sh #{install_dir}/bin/#{c}.sh"
  end
  command "chmod +x #{install_dir}/bin/*"
end
