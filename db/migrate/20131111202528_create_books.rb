class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
	  t.string :title
	  t.string :category
	  t.string :author
	  t.string :publisher
	  t.boolean :returned
	  t.string :isbn

      t.timestamps
    end
  end
end
