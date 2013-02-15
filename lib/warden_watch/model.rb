module WardenWatch
  module Model
    extend ActiveSupport::Concern

    included do
      has_many :visits,
        :class_name => '::WardenWatch::UserVisit',
        :as         => :visitor,
        :dependent  => :destroy,
        :inverse_of => :visitor
    end

    def track_visit!(auth, opts)
      req = Rack::Request.new(auth.env)
      visits.create! do |v|
        v.ip_address = req.ip
      end
    end
  end
end

