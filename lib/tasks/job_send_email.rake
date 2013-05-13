namespace :job do

  desc "send birthday email"
  task :send_email => :environment do
     puts "STARTTING  send birthday email JOB "
     puts Time.now
    User.send_email_through_delayed_jobs

  end

end