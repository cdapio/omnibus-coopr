name 'coopr-cloudui'
maintainer 'Cask'
homepage 'https://coo.pr'

install_dir '/opt/coopr/cloudui'
# build_version   Omnibus::BuildVersion.semver
build_version '0.9.9'
build_iteration 1

# conflict with standalone
# conflicts 'coopr-standalone'

# Version overrides
override :nodejs, version: '0.10.26'

# creates required build directories
dependency 'preparation'

# coopr-ui dependencies/components
dependency 'coopr-cloudui'

exclude "\.git*"
exclude "bundler\/git"
