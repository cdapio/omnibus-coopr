name 'coopr-server'
maintainer 'Cask'
homepage 'http://github.com/caskdata/coopr'

install_dir '/opt/coopr/server'

# For release builds, uncomment the following, or provide --override append_timestamp:false
# append_timestamp false
build_version '0.9.9'
build_iteration 1

# conflict with standalone
# conflicts 'coopr-standalone'

# creates required build directories
dependency 'preparation'

# coopr-provisioner dependencies/components
# dependency "somedep"
dependency 'coopr-server'

exclude "\.git*"
exclude "bundler\/git"
