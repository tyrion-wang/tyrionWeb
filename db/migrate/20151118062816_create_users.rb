class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :cellphone
      t.string :password
      t.integer :gender, :default => 0
      t.integer :age, :default => 0
      t.string :brief
      t.string :portrait_img

      t.timestamps null: false
    end
  end
end
