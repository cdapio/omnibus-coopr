name 'coopr-cli'
maintainer 'Cask'
homepage 'http://github.com/cdapio/coopr'

install_dir '/opt/coopr/cli'

# For release builds, uncomment the following, or provide --override append_timestamp:false
# append_timestamp false
build_version '0.9.9'
build_iteration 1

# conflict with standalone
# conflicts 'coopr-standalone'

# creates required build directories
dependency 'preparation'

# coopr-cli dependencies/components
# dependency "somedep"
dependency 'coopr-cli'

exclude "\.git*"
exclude "bundler\/git"
