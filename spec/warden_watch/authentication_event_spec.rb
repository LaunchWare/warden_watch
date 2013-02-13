require 'spec_helper'

describe WardenWatch::AuthenticationEvent do
  let(:mock_user) do
    mock.tap do |m|
      m.stubs(:track_visit!)
    end
  end

  let(:auth) { [200, {}, ''] }
  let(:opts) { { :event => :not_fetch} }

  let(:auth_event) do
    WardenWatch::AuthenticationEvent.new(mock_user, auth, opts)
  end

  it 'tracks an authentication event when it is not fetch' do
    auth_event.track!

    expect(mock_user).to have_received(:track_visit!).once
  end

  it 'does not track an authentication event when it is fetch' do
    opts[:event] = :fetch
    expect(mock_user).to have_received(:track_visit!).never
  end
end

