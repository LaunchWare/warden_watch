require 'warden_watch/model'

module WardenWatch
  class Engine < ::Rails::Engine
    isolate_namespace WardenWatch

    config.generators do |g|
      g.orm             :active_record
      g.template_engine :erb
    end
  end
end

