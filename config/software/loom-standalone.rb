name "loom-standalone"
default_version "develop"

source :git => "git://github.com/continuuity/loom.git"
relative_path 'standalone'

build do
  command "mkdir -p #{install_dir}/bin"
  command "cp -fpPR standalone/bin/loom.sh #{install_dir}/bin"
  %w[ provisioner server ui ].each do |c|
    command "ln -sf #{install_dir}/#{c}/bin/loom-#{c}.sh #{install_dir}/bin/loom-#{c}.sh"
  end
end
