class CreateBaseEntities < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :user,        index: true, null: false
      t.string     :name,                     null: false
      t.string     :description,              null: false, default: ""
      t.datetime   :start_at
      t.datetime   :end_at
      t.timestamps
    end

    create_table :event_users do |t|
      t.belongs_to :user,  index: true, null: false
      t.belongs_to :event, index: true, null: false
    end

    create_table :invitations do |t|
      t.belongs_to :event, index: true, null: false
      t.belongs_to :user,  index: true, null: false
      t.string     :token,              null: false, default: ""
      t.timestamps
    end

    create_table :availabilities do |t|
      t.belongs_to :user,      index: true, null: false
      t.datetime   :start_at,               null: false
      t.datetime   :end_at,                 null: false
      t.timestamps
    end
  end
end
