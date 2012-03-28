class TeamsWorkers < ActiveRecord::Migration
  def up
    create_table :teams_workers do |t|
       t.integer  :team_id
       t.integer  :worker_id
     end
  end

  def down
    drop_table :teams_workers
   end
end
