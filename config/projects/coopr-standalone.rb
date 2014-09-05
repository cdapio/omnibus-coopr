name 'coopr-standalone'
maintainer 'Cask'
homepage 'http://github.com/continuuity/loom'

install_path '/opt/coopr'
build_version   Omnibus::BuildVersion.semver
# build_version '0.9.7'
build_iteration 1

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
