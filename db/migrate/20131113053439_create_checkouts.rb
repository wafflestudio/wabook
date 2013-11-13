class CreateCheckouts < ActiveRecord::Migration
  def change
    create_table :checkouts do |t|
	  t.integer :book_id
	  t.integer :user_id
	  t.datetime :checkoutdate
	  t.datetime :duedate
	  t.boolean :returned

      t.timestamps
    end
  end
end
