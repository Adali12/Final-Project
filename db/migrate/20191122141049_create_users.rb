class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :firstName
      t.string :lastName
      t.string :email
      t.string :address
      t.string :bio
      t.string :occupation
      t.string :expertise
      t.boolean :admin, default: false
      t.boolean :mentor, default: false
      t.string :password_digest

      t.timestamps
    end
  end
end
