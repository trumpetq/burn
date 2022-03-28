namespace :newsletter do
  task assign: :environment do
    ActiveRecord::Base.establish_connection(ENV["PRODUCTION_DATABASE_URL"])
    newsletters = ::Newsletter.where(user_id: nil)

    newsletters.each do |newsletter|
      user = ::User.for_email(newsletter.email).take
      if user.present?
        if user.newsletter
          puts Rainbow("#{user.to_log} has a newsletter mismatch.").red
        else
          puts Rainbow("#{user.to_log} will be assigned #{newsletter.to_log}.").green
        end
      end
    end
  end
end