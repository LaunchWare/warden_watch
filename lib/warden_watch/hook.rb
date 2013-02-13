module WardenWatch
  class Hook
    class << self
      def enable!
        #warden hook code goes here
      end
    end
  end
end

WardenWatch::Hook.enable!

