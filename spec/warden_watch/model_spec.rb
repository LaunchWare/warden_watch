require 'spec_helper'

describe WardenWatch::Model do
  class User < ActiveRecord::Base
    self.table_name = 'users'

    include WardenWatch::Model
  end

  subject { User.new }

  it { should have_many :visits }

  it 'logs a visit record' do
    user = User.new
    track_visit(user, mock_request('/'), {})
    user.visits.count.should eql(1)
  end

  it 'logs the ip address' do
    user = User.new
    env = mock_request('/')
    env['REMOTE_ADDR'] = '127.0.0.1'
    track_visit(user, env, {})
    user.visits.first.ip_address.should_not be_nil
  end

  protected
  def mock_request(path)
    Rack::MockRequest.env_for("/")
  end

  def track_visit(user, env, opts)
    user.save!
    user.track_visit!(env, opts)
  end
end

