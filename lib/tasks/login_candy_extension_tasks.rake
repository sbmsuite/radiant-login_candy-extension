namespace :radiant do
  namespace :extensions do
    namespace :login_candy do
      
      desc "Runs the migration of the Login Candy extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          LoginCandyExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          LoginCandyExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Login Candy to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        puts "Copying assets from LoginCandyExtension"
        Dir[LoginCandyExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(LoginCandyExtension.root, '')
          directory = File.dirname(path)
          mkdir_p RAILS_ROOT + directory, :verbose => false
          cp file, RAILS_ROOT + path, :verbose => false
        end
        unless LoginCandyExtension.root.starts_with? RAILS_ROOT # don't need to copy vendored tasks
          puts "Copying rake tasks from LoginCandyExtension"
          local_tasks_path = File.join(RAILS_ROOT, %w(lib tasks))
          mkdir_p local_tasks_path, :verbose => false
          Dir[File.join LoginCandyExtension.root, %w(lib tasks *.rake)].each do |file|
            cp file, local_tasks_path, :verbose => false
          end
        end
      end  
    end
  end
end
