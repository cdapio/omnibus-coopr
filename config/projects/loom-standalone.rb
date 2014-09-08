name 'loom-standalone'
maintainer 'Continuuity'
homepage 'http://github.com/continuuity/loom'

install_path '/opt/loom'
build_version   Omnibus::BuildVersion.semver
# build_version '0.9.7'
build_iteration 1

# conflict with non-standalone
# conflicts 'loom-provisioner'
# conflicts 'loom-server'
# conflicts 'loom-ui'

# Version overrides
override :nodejs, version: '0.10.26'

# creates required build directories
dependency 'preparation'

# loom-provisioner dependencies/components
# dependency "somedep"
dependency 'loom-provisioner'
dependency 'loom-server'
dependency 'loom-ui'
dependency 'loom-standalone'

# version manifest file
dependency 'version-manifest'

exclude "\.git*"
exclude "bundler\/git"
