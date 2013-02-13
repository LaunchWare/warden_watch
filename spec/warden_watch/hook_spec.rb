require 'spec_helper'
require 'rack/test'

describe WardenWatch::Hook do
  include Warden::Test::Helpers

  before :all do
    Warden.test_mode!
  end

  before(:each) do
    Warden::Manager._after_set_user.clear
  end

  it 'tracks an authentication event when a user is set' do
    mock_auth_event = mock.tap do |m|
      m.stubs(:track!)
    end

    WardenWatch::AuthenticationEvent.stubs(:new).returns(mock_auth_event)
    WardenWatch::Hook.enable!

    app = lambda do |e|
      e['warden'].set_user("foo")
      valid_response
    end

    env = env_with_params
    setup_rack(app).call(env)

    expect(mock_auth_event).to have_received(:track!).once
  end

  protected
  #taken from warden core
  def setup_rack(app = nil, opts = {}, &block)
    app ||= block if block_given?

    opts[:failure_app]         ||= [500, {}, 'Error']
    opts[:default_strategies]  ||= [:password]
    opts[:default_serializers] ||= [:session]
    blk = opts[:configurator] || proc{}

    Rack::Builder.new do
      use opts[:session] || SessionHelper
      use Warden::Manager, opts, &blk
      run app
    end
  end

  def env_with_params(path = "/", params = {}, env = {})
    method = params.delete(:method) || "GET"
    env = { 'HTTP_VERSION' => '1.1', 'REQUEST_METHOD' => "#{method}" }.merge(env)
    Rack::MockRequest.env_for("#{path}?#{Rack::Utils.build_query(params)}", env)
  end

  def valid_response
    Rack::Response.new("OK").finish
  end


  class SessionHelper
    attr_accessor :app
    def initialize(app,configs = {})
      @app = app
    end

    def call(e)
      e['rack.session'] ||= {}
      @app.call(e)
    end
  end
end

