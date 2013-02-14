module WardenWatch
  class AuthenticationEvent
    def initialize(user, auth, opts)
      @user = user
      @auth = auth
      @opts = opts
    end

    def track!
      if track?
        @user.track_visit!(@auth, @opts)
      end
    end

    protected
    def track?
      @opts[:event].to_s != 'fetch'
    end
  end
end

