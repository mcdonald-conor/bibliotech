class AddDetailsToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :title, :string unless column_exists?(:books, :title)
    add_column :books, :author, :string unless column_exists?(:books, :author)
    add_column :books, :description, :text unless column_exists?(:books, :description)
    add_column :books, :source, :string unless column_exists?(:books, :source)
    add_column :books, :isbn, :string unless column_exists?(:books, :isbn)
  end
end
