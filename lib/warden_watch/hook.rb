require 'warden'

module WardenWatch
  class Hook
    class << self
      def enable!
        Warden::Manager.after_set_user do |user,auth,opts|
          WardenWatch::AuthenticationEvent.new(user, auth, opts).track!
        end
      end
    end
  end
end

