class ChangeCollectionIdInBooks < ActiveRecord::Migration[6.1]
  def change
    change_column_null :books, :collection_id, true
  end
end
