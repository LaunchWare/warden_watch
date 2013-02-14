require 'spec_helper'

describe WardenWatch::UserVisit do
  class User < ActiveRecord::Base
    self.table_name = 'users'

    include WardenWatch::Model
  end

  it { should belong_to :visitor }
end

