require 'csv'

task :nonprofit_reachout => :environment do |t, args|
  nonprofits = []
  CSV.foreach("db/reachout/nonprofit.csv") do |row|
    nonprofits << {
      :name => row[0].strip,
      :short_name => row[1].strip,
      :first_name => "#{row[2].strip if row[2].present?}",
      :email => row[3].strip
    }
  end

  nonprofits = nonprofits.sample(5) # Test random sample

  nonprofits.each do |nonprofit|
    puts "Sending to #{nonprofit[:email]} - #{nonprofit[:name]}"
    ReachoutMailer.nonprofit(nonprofit).deliver
  end
end