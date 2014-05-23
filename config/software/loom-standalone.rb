name 'loom-standalone'
default_version 'release/0.9.7'

source :git => 'git://github.com/continuuity/loom.git'
relative_path 'standalone'

build do
  command "mkdir -p #{install_dir}/bin"
  command "cp -fpPR bin/loom-0.9.7-upgrade.rb #{install_dir}/bin"
  command "sed -e 's#_NODE:-node#_NODE:-/opt/loom/embedded/bin/node#g' -e 's#_RUBY:-ruby#_RUBY:-/opt/loom/embedded/bin/ruby#g' standalone/bin/loom.sh > #{install_dir}/bin/loom.sh"
  %w(provisioner server ui).each do |c|
    command "ln -sf #{install_dir}/#{c}/bin/loom-#{c}.sh #{install_dir}/bin/loom-#{c}.sh"
  end
  command "chmod +x #{install_dir}/bin/*"
end
