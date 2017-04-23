class ChangesForSiritori < ActiveRecord::Migration[5.0]
  def change
    add_index :statuses, :text
    add_column :statuses, :is_siritori_success, :boolean, null: false

    create_table :account_siritori_data do |t|
      t.integer :account_id, null: false
      t.integer :level, default: 0, null: false
    end
    add_index :account_siritori_data , :account_id
  end
end
