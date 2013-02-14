class CreateWardenWatchUserVisits < ActiveRecord::Migration
  def change
    create_table :warden_watch_user_visits do |t|
      t.string :ip_address
      t.references :visitor, :polymorphic => true
      t.timestamps
    end

    add_index :warden_watch_user_visits, [:visitor_id, :visitor_type]
  end
end

