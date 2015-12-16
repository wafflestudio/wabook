class AddDescriptionCoverUrlToBooks < ActiveRecord::Migration
  def change
    add_column :books, :description, :text
    add_column :books, :cover_url, :string
  end
end
