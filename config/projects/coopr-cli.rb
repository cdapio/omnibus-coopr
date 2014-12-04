name 'coopr-cli'
maintainer 'Cask'
homepage 'http://github.com/caskdata/coopr'

install_dir '/opt/coopr/cli'
build_version   Omnibus::BuildVersion.semver
# build_version '0.9.8'
build_iteration 1

# conflict with standalone
# conflicts 'coopr-standalone'

# creates required build directories
dependency 'preparation'

# coopr-provisioner dependencies/components
# dependency "somedep"
dependency 'coopr-cli'

exclude "\.git*"
exclude "bundler\/git"
