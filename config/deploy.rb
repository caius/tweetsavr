# The name of your application.  Used for deployment directory and filenames.
set :application, "tweetsavr"

# Primary domain name of your application.
set :domain, "tweetsavr.com"

## List of servers
server "nonus.vm.caius.name", :app, :web, :db, :primary => true

# Target directory for the application on the web and app servers.
set(:deploy_to) { File.join("", "home", user, "apps", application) }
set :user, "caius"

# Repo details
set :repository, "git://github.com/caius/tweetsavr.git"
set :scm, :git
set :deploy_via, :remote_cache
set :git_enable_submodules, 1
set :branch, "master"
ssh_options[:forward_agent] = true

# Forces a Pty so that svn+ssh repository access will work. You
# don't need this if you are using a different SCM system. Note that
# ptys stop shell startup scripts from running.
default_run_options[:pty] = true

set :use_sudo, false

set :local_shared_files, %w(config/newrelic.yml config/twitter.yml)
set :local_shared_dirs, %w(cache)

set :global_shared_files, []
set :global_shared_dirs, []
set :global_shared_path, "~"

after "deploy:setup",
  "deploy:shared:global:setup",
  "deploy:shared:local:setup"

after "deploy:finalize_update",
  "deploy:shared:global:symlink",
  "deploy:shared:local:symlink"

after "deploy:symlink",
  "deploy:bundle:install"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  namespace :bundle do
    task :install do
      run %{cd #{current_path} && bundle install --path #{shared_path}/bundle --deployment --without development test && ln -sf #{shared_path}/bundle #{current_path}/vendor/}
    end
  end
end
