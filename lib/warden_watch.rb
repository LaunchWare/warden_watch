require 'warden_watch/version'

require 'warden_watch/authentication_event'
require 'warden_watch/hook'

if defined?(Rails)
  require 'warden_watch/engine'
end

module WardenWatch
end

