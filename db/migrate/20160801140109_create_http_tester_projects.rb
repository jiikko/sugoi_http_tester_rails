class CreateHttpTesterProjects < ActiveRecord::Migration
  def change
    create_table :sugoi_http_tester_rails_projects do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
