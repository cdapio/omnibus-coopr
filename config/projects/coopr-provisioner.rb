name 'coopr-provisioner'
maintainer 'Cask'
homepage 'http://github.com/caskdata/coopr'

install_dir '/opt/coopr/provisioner'

# For release builds, uncomment the following, or provide --override append_timestamp:false
# append_timestamp false
build_version '0.9.9'
build_iteration 1

# conflict with standalone
# conflicts 'coopr-standalone'

override :ruby, version: '2.5.1'

# creates required build directories
dependency 'preparation'

# coopr-provisioner dependencies/components
# dependency "somedep"
dependency 'coopr-provisioner'

exclude "\.git*"
exclude "bundler\/git"
