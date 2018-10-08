name 'coopr-ui'
maintainer 'Cask'
homepage 'http://github.com/caskdata/coopr'

install_dir '/opt/coopr/ui'

# For release builds, uncomment the following, or provide --override append_timestamp:false
# append_timestamp false
build_version '0.9.9'
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
