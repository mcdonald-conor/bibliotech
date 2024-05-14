class CreateMedia < ActiveRecord::Migration[7.1]
  def change
    create_table :media do |t|
      t.references :user, null: false, foreign_key: true
      t.string :category
      t.text :description
      t.string :source
      t.references :collection, null: false, foreign_key: true

      t.timestamps
    end
  end
end
