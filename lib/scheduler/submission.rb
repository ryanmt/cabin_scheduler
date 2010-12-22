#Model for submissions
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
    property :created_on, DateTime, :default => lambda { |r, p| Time.now }
    property :updated_on, DateTime, :default => lambda { |r, p| Time.now }
    property :display, Boolean, :default => true

    before :save do
      updated_on = Time.now
    end
  end
end

DataMapper.finalize