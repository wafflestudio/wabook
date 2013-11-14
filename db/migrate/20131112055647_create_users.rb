class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.timestamps
      t.boolean :is_admin, :default => false
    end
  end
end
