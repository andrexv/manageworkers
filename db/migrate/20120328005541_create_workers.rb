class CreateWorkers < ActiveRecord::Migration
  def self.up
    create_table :workers do |t|
      t.string  :name
      t.string  :email
      t.string  :home_address
      t.string  :mobile_number
      t.string  :landline_number
      t.string  :office_address
      t.string  :office_phone
      t.string  :twitter
      t.string  :facebook
      t.string  :tw_avatar
      
      t.timestamps
    end
  end
  def self.down
    drop_table :workers
  end
end
