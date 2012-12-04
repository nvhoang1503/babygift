namespace :db do
  desc 'Drop, re-create and populate sample data'
  task :bootstrap => [:drop, :create, :migrate, :seed]
end

namespace :db do
  desc 'Load the sample data from db/sample_data.rb'
  # task :sample_data => :environment do
  #   seed_file = File.join(Rails.root, 'db', 'sample_data.rb')
  #   load(seed_file) if File.exist?(seed_file)
  # end
end
