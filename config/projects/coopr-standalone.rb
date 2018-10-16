name 'coopr-standalone'
maintainer 'Cask'
homepage 'http://github.com/caskdata/coopr'

install_dir '/opt/coopr'

# For release builds, uncomment the following, or provide --override append_timestamp:false
# append_timestamp false
build_version '0.9.9'
build_iteration 1

# conflict with non-standalone
# conflicts 'coopr-provisioner'
# conflicts 'coopr-server'
# conflicts 'coopr-ui'

# Version overrides
override :nodejs, version: '0.10.26'

# creates required build directories
dependency 'preparation'

# coopr-provisioner dependencies/components
# dependency "somedep"
dependency 'coopr-provisioner'
dependency 'coopr-server'
dependency 'coopr-ui'
dependency 'coopr-standalone'

# version manifest file
dependency 'version-manifest'

exclude "\.git*"
exclude "bundler\/git"
