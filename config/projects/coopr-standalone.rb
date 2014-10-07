name 'coopr-standalone'
maintainer 'Cask'
homepage 'http://github.com/caskdata/coopr'

install_dir '/opt/coopr'
build_version   Omnibus::BuildVersion.semver
# build_version '0.9.8'
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
dependency 'coopr-ngui'
dependency 'coopr-standalone'

# version manifest file
dependency 'version-manifest'

exclude "\.git*"
exclude "bundler\/git"
