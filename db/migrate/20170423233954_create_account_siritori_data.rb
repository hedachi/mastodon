class CreateAccountSiritoriData < ActiveRecord::Migration[5.0]
  def change
    create_table :account_siritori_data do |t|
      t.integer :account_id, null: false
      t.integer :level, default: 1, null:false
      t.integer :stamina, default: 0, null: false

      t.timestamps
    end
  end
end
