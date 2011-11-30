#!/usr/bin/env ruby

require 'json'
require 'socket'
require 'alpha_omega/deploy'

ssh_options[:forward_agent] = true

set :user, "defn"
set :group, "defn"

set :root_user, "defn"
set :root_group, "defn"

set :use_sudo, false

set :ruby_loader, "#{ENV['HOME']}/bin/rvmrun default"
set :bundler_options, "--path vendor/bundle"

# branch
set :branch, AlphaOmega.what_branch

# host groups
hosts =
  AlphaOmega.what_hosts 'work/nodes/*.json' do |node|
    if node[:node_name] && node["public_ip"]
      node_task = node[:node_name].to_sym
      task node_task do
        role :app, node[:node_name]
      end
    end
  end

# localhost
task :localhost do
  role :app, Socket.gethostname
end

groups =
  AlphaOmega.what_groups hosts do |nm_group, group|
    task nm_group.to_sym do
    end

    group.keys.sort.each do |nm_node|
      before nm_group, nm_node
    end
  end

# home
task :home do
  set :application, "badonkadonk"
  set :repository, "git@github.com:HeSYINUvSBZfxqA/badonkadonk.git"

  set :releases, [ ]
  set :deploy_to, (ENV['DEPLOY_TO'] || ENV['HOME'])
  set :dir_perms, "0750"
end

# apps
task :dailo do
  set :application, "dailo"
  set :repository, "git@github.com:HeSYINUvSBZfxqA/dailo.git"
  set :releases, [ "alpha", "omega" ]
  set :deploy_to, File.join(Dir.pwd, "apps", application)

end

# catch all hosts
(ENV['_HOSTS'] || "").split(/[,\s]+/).each do |h|
  before "home", h
end

task :git_remote do
  # workaround git clone and non-empty directories
  run "[[ -d .git ]] || { git init && git remote add origin #{repository}; }"
end

task :bundler_gecode_options do
  run "#{ruby_loader} bundle config build.dep_selector --with-opt-dir=#{ENV['HOME']}/local"
end

task :gecode_build do
  run "[[ -x #{ENV['HOME']}/local/bin/sat ]] || { cd #{ENV['HOME']}/build && ./build-gecode; }"
end

task :vim_build do
  run "vim -E -c ':source .vimrc' -c :quit meh"
end

after "deploy:bootstrap_code", "git_remote"

before "deploy:bundle", "bundler_gecode_options"

after "deploy:update_code", "gecode_build"
after "deploy:update_code", "vim_build"


