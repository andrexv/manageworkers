class AddMoreInfoToWorkers < ActiveRecord::Migration
  def change
    change_table(:workers) do |t|
      t.string :gender
      t.string :hometown
      t.string :location
      t.string :fb_id
      t.string :fb_nickname
      t.string :fb_image      
    end
  end
end
