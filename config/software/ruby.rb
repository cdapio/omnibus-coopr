#
# Copyright:: Copyright (c) 2012-2014 Chef Software, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name "ruby"
default_version "1.9.3-p550"

dependency "zlib"
dependency "ncurses"
dependency "libedit"
dependency "openssl"
dependency "libyaml"
dependency "libiconv"
dependency "libffi"
dependency "gdbm"
dependency "libgcc" if Ohai['platform'] == "solaris2"

version("1.9.3-p484") { source md5: "8ac0dee72fe12d75c8b2d0ef5d0c2968" }
version("1.9.3-p547") { source md5: "7531f9b1b35b16f3eb3d7bea786babfd" }
version("1.9.3-p550") { source md5: "e05135be8f109b2845229c4f47f980fd" }
version("2.1.1")      { source md5: "e57fdbb8ed56e70c43f39c79da1654b2" }
version("2.1.2")      { source md5: "a5b5c83565f8bd954ee522bd287d2ca1" }
version("2.1.3")      { source md5: "74a37b9ad90e4ea63c0eed32b9d5b18f" }
version("2.1.4")      { source md5: "89b2f4a197621346f6724a3c35535b19" }

version("2.5.1")      { source sha256: "dac81822325b79c3ba9532b048c2123357d3310b2b40024202f360251d9829b1" }
version("2.5.0")      { source sha256: "46e6f3630f1888eb653b15fa811d77b5b1df6fd7a3af436b343cfe4f4503f2ab" }

version("2.4.4")      { source sha256: "254f1c1a79e4cc814d1e7320bc5bdd995dc57e08727d30a767664619a9c8ae5a" }
version("2.4.3")      { source sha256: "fd0375582c92045aa7d31854e724471fb469e11a4b08ff334d39052ccaaa3a98" }
version("2.4.2")      { source sha256: "93b9e75e00b262bc4def6b26b7ae8717efc252c47154abb7392e54357e6c8c9c" }
version("2.4.1")      { source sha256: "a330e10d5cb5e53b3a0078326c5731888bb55e32c4abfeb27d9e7f8e5d000250" }
version("2.4.0")      { source sha256: "152fd0bd15a90b4a18213448f485d4b53e9f7662e1508190aa5b702446b29e3d" }

version("2.3.7")      { source md5: "d8afe2fa44f9a14cac337d4344ff216e" }
version("2.3.6")      { source sha256: "8322513279f9edfa612d445bc111a87894fac1128eaa539301cebfc0dd51571e" }
version("2.3.5")      { source sha256: "5462f7bbb28beff5da7441968471ed922f964db1abdce82b8860608acc23ddcc" }
version("2.3.4")      { source sha256: "98e18f17c933318d0e32fed3aea67e304f174d03170a38fd920c4fbe49fec0c3" }
version("2.3.3")      { source sha256: "241408c8c555b258846368830a06146e4849a1d58dcaf6b14a3b6a73058115b7" }
version("2.3.1")      { source sha256: "b87c738cb2032bf4920fef8e3864dc5cf8eae9d89d8d523ce0236945c5797dcd" }
version("2.3.0")      { source md5: "e81740ac7b14a9f837e9573601db3162" }

version("2.2.10")     { source sha256: "cd51019eb9d9c786d6cb178c37f6812d8a41d6914a1edaf0050c051c75d7c358" }
version("2.2.9")      { source sha256: "2f47c77054fc40ccfde22501425256d32c4fa0ccaf9554f0d699ed436beca1a6" }
version("2.2.8")      { source sha256: "8f37b9d8538bf8e50ad098db2a716ea49585ad1601bbd347ef84ca0662d9268a" }
version("2.2.6")      { source sha256: "de8e192791cb157d610c48a9a9ff6e7f19d67ce86052feae62b82e3682cc675f" }
version("2.2.5")      { source md5: "bd8e349d4fb2c75d90817649674f94be" }
version("2.2.4")      { source md5: "9a5e15f9d5255ba37ace18771b0a8dd2" }
version("2.2.3")      { source md5: "150a5efc5f5d8a8011f30aa2594a7654" }
version("2.2.2")      { source md5: "326e99ddc75381c7b50c85f7089f3260" }
version("2.2.1")      { source md5: "b49fc67a834e4f77249eb73eecffb1c9" }
version("2.2.0")      { source md5: "cd03b28fd0b555970f5c4fd481700852" }

source url: "http://cache.ruby-lang.org/pub/ruby/#{version.match(/^(\d+\.\d+)/)[0]}/ruby-#{version}.tar.gz"

relative_path "ruby-#{version}"

env = with_embedded_path()
env = with_standard_compiler_flags(env)

case Ohai['platform']
when "mac_os_x"
  # -Qunused-arguments suppresses "argument unused during compilation"
  # warnings. These can be produced if you compile a program that doesn't
  # link to anything in a path given with -Lextra-libs. Normally these
  # would be harmless, except that autoconf treats any output to stderr as
  # a failure when it makes a test program to check your CFLAGS (regardless
  # of the actual exit code from the compiler).
  env['CFLAGS'] << " -I#{install_dir}/embedded/include/ncurses -arch x86_64 -m64 -O3 -g -pipe -Qunused-arguments"
  env['LDFLAGS'] << " -arch x86_64"
when "aix"
  # -O2/O3 optimized away some configure test which caused ext libs to fail, so aix only gets -O
  #
  # We also need prezl's M4 instead of picking up /usr/bin/m4 which
  # barfs on ruby.
  #
  # I believe -qhot was necessary to prevent segfaults in threaded libs
  #
  env['CFLAGS'] << " -q64 -qhot"
  env['M4'] = "/opt/freeware/bin/m4"
  env['warnflags'] = "-qinfo=por"
else  # including solaris, linux
  env['CFLAGS'] << " -O3 -g -pipe"
end

build do
  configure_command = ["./configure",
                       "--prefix=#{install_dir}/embedded",
                       "--with-out-ext=dbm",
                       "--enable-shared",
                       "--enable-libedit",
                       "--with-ext=psych",
                       "--disable-install-doc",
                       "--without-gmp"]

  case Ohai['platform']
  when "aix"
    patch :source => "ruby-aix-configure.patch", :plevel => 1
    patch :source => "ruby_aix_1_9_3_448_ssl_EAGAIN.patch", :plevel => 1
    # our openssl-1.0.1h links against zlib and mkmf tests will fail due to zlib symbols not being
    # found if we do not include -lz.  this later leads to openssl functions being detected as not
    # being available and then internally vendored versions that have signature mismatches are pulled in
    # and the compile explodes.  this problem may not be unique to AIX, but is severe on AIX.
    patch :source => "ruby_aix_openssl.patch", :plevel => 1
    # --with-opt-dir causes ruby to send bogus commands to the AIX linker
  when "freebsd"
    configure_command << "--without-execinfo"
    configure_command << "--with-opt-dir=#{install_dir}/embedded"
  when "smartos"
    # Opscode patch - someara@opscode.com
    # GCC 4.7.0 chokes on mismatched function types between OpenSSL 1.0.1c and Ruby 1.9.3-p286
    patch :source => "ruby-openssl-1.0.1c.patch", :plevel => 1

    # Patches taken from RVM.
    # http://bugs.ruby-lang.org/issues/5384
    # https://www.illumos.org/issues/1587
    # https://github.com/wayneeseguin/rvm/issues/719
    patch :source => "rvm-cflags.patch", :plevel => 1

    # From RVM forum
    # https://github.com/wayneeseguin/rvm/commit/86766534fcc26f4582f23842a4d3789707ce6b96
    configure_command << "ac_cv_func_dl_iterate_phdr=no"
    configure_command << "--with-opt-dir=#{install_dir}/embedded"
  else
    configure_command << "--with-opt-dir=#{install_dir}/embedded"
  end

  # @todo expose bundle_bust() in the DSL
  env.merge!({
    "RUBYOPT"         => nil,
    "BUNDLE_BIN_PATH" => nil,
    "BUNDLE_GEMFILE"  => nil,
    "GEM_PATH"        => nil,
    "GEM_HOME"        => nil
  })

  # @todo: move into omnibus-ruby
  has_gmake = system("gmake --version")

  if has_gmake
    env.merge!({'MAKE' => 'gmake'})
    make_binary = 'gmake'
  else
    make_binary = 'make'
  end

  # FFS: works around a bug that infects AIX when it picks up our pkg-config
  # AFAIK, ruby does not need or use this pkg-config it just causes the build to fail.
  # The alternative would be to patch configure to remove all the pkg-config garbage entirely
  env.merge!({
    "PKG_CONFIG" => "/bin/true",
  }) if Ohai['platform'] == "aix"

  command configure_command.join(" "), :env => env
  command "#{make_binary} -j #{max_build_jobs}", :env => env
  command "#{make_binary} -j #{max_build_jobs} install", :env => env
end
