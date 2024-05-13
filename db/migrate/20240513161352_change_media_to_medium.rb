class ChangeMediaToMedium < ActiveRecord::Migration[7.1]
  def change
    rename_table :media, :medium
  end
end
