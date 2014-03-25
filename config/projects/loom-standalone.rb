
name "loom-standalone"
maintainer "Continuuity"
homepage "http://github.com/continuuity/loom"

replaces        "loom"
install_path    "/opt/loom"
#build_version   Omnibus::BuildVersion.new.semver
build_version "0.9.5"
build_iteration 101

# creates required build directories
dependency "preparation"

# loom-provisioner dependencies/components
# dependency "somedep"
dependency "loom-provisioner"
dependency "loom-server"
dependency "loom-ui"
dependency "loom-standalone"

# version manifest file
dependency "version-manifest"

exclude "\.git*"
exclude "bundler\/git"
