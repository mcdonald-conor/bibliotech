class AddCollectionToMedia < ActiveRecord::Migration[7.1]
  def change
    add_reference :media, :collection, null: false, foreign_key: true
  end
end
