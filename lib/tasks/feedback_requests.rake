namespace :feedback do
  task :send_all_requests => :environment do
    FeedbackRequestSender.new.send_all_requests
  end

  task :report do
    unless ENV["DATABASE_URL"]
      $stderr.puts "DATABASE_URL not set. To setup, do the following:"
      $stderr.puts "\t1) `heroku config:get DATABASE_URL`"
      $stderr.puts "\t2) `export DATABASE_URL=...`"
      abort
    end

    # Call .establish_connection directly before running the environment task
    # so that AR loads database from ENV["DATABASE_URL"]
    ActiveRecord::Base.establish_connection
    Rake::Task["environment"].invoke

    FeedbackReport.new(ENV["LIMIT"]).run
  end
end