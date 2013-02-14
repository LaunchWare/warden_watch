module WardenWatch
  class UserVisit < ActiveRecord::Base
    belongs_to :visitor,
      :polymorphic => true,
      :inverse_of => :visits

    attr_accessible nil
  end
end
