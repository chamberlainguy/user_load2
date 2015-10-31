class CreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :email_address,	:null => false, :default => ""
      t.string :first_name,     :null => false, :default => ""
      t.string :last_name,     	:null => false, :default => ""
      t.integer :parent_id,     
      t.timestamps
    end
    add_index(:users, [:email_address], unique: true)
  end
end
