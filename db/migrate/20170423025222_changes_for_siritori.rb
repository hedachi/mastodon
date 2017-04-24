class ChangesForSiritori < ActiveRecord::Migration[5.0]
  def change
    add_index :statuses, :text
    add_column :statuses, :is_siritori_success, :boolean, null: false
  end
end
