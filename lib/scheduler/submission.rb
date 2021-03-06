#Model for submissions
require "pony"
module Scheduler
  class Submission
    include DataMapper::Resource

    property :id, Serial
    property :name, String
    property :principal_investigator, String
    property :department, String
    property :email, String
    property :phone_number, String
    property :sample_type, String
    property :number_of_samples, Integer
    property :sample_origin, String
    property :sample_description, Text
    property :date, String
    property :time, String
    property :created_on, DateTime, :default => lambda { |r, p| Time.now }
    property :updated_on, DateTime, :default => lambda { |r, p| Time.now }
    property :display, Boolean, :default => true

    def mail(to, from, options={})
      Pony.mail(:to => to.to_s,
                :from => from.to_s,
                :subject => "New Signup for the Orbitrap",
                :body => "#{name} (email: #{email}) has signed up to use the orbitrap.
Date: #{date}
Time: #{time}
Principal Investigator: #{principal_investigator}
Department: #{department}
Phone Number: #{phone_number}
Sample Type: #{sample_type}
Number Of Samples: #{number_of_samples}
Sample Origin: #{sample_origin}
Sample Description: #{sample_description}",
                :port => settings.email_port,
                :via => :smtp,
                :via_options => {
                  :address => settings.email_smtp_address,
                  :port => settings.email_port,
                  :user_name => settings.email_username,
                  :password => settings.email_password,
                  :domain => settings.email_domain,
                  :authentication => :plain
                })
    end

    before :save do
      updated_on = Time.now
    end
  end
end

DataMapper.finalize
