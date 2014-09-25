name 'coopr-standalone'
default_version 'feature/refactor-l2c'

source :git => 'git://github.com/continuuity/loom.git'
relative_path 'coopr-standalone'

build do
  mkdir "#{install_dir}/bin"
  command "sed -e 's#_NODE:-node#_NODE:-/opt/coopr/embedded/bin/node#g' -e 's#_RUBY:-ruby#_RUBY:-/opt/coopr/embedded/bin/ruby#g' coopr-standalone/bin/coopr.sh > #{install_dir}/bin/coopr.sh"
  %w(provisioner server ngui ui).each do |c|
    link "#{install_dir}/#{c}/bin/#{c}.sh", "#{install_dir}/bin/#{c}.sh"
  end
  command "chmod +x #{install_dir}/bin/*"
end
