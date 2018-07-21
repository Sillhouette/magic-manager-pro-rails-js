class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :name
      t.string :uid
      t.string :email
      t.string :image
      t.integer :dci_number
      t.timestamps
    end
  end
end
