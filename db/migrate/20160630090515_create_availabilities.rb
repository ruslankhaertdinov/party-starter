class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.belongs_to :user,  null: false, index: true
      t.belongs_to :event, null: false, index: true
      t.jsonb :intervals,  null: false, default: {}
      t.timestamps
    end

    drop_table :invitations do |t|
      t.belongs_to :event, index: true, null: false
      t.belongs_to :user,  index: true, null: false
      t.string     :token,              null: false, default: ""
      t.timestamps
    end

    remove_column :users, :availability, :jsonb, null: false, default: {}
  end
end
