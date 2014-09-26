name 'coopr-ui'
maintainer 'Cask'
homepage 'http://github.com/caskdata/coopr'

install_dir '/opt/coopr/ui'
# build_version   Omnibus::BuildVersion.semver
build_version '0.9.8'
build_iteration 1

# conflict with standalone
# conflicts 'coopr-standalone'

# Version overrides
override :nodejs, version: '0.10.26'

# creates required build directories
dependency 'preparation'

# coopr-ui dependencies/components
dependency 'coopr-ui'

exclude "\.git*"
exclude "bundler\/git"
