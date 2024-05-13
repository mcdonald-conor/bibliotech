class CreateMedium < ActiveRecord::Migration[7.1]
  def change
    create_table :medium do |t|
      t.references :user, null: false, foreign_key: true
      t.string :category
      t.text :description
      t.string :source
      t.references :collection, null: false, foreign_key: true

      t.timestamps
    end
  end
end
