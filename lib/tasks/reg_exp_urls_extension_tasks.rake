namespace :radiant do
  namespace :extensions do
    namespace :reg_exp_urls do
      
      desc "Runs the migration of the Reg Exp Urls extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          RegExpUrlsExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          RegExpUrlsExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Reg Exp Urls to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[RegExpUrlsExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(RegExpUrlsExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
