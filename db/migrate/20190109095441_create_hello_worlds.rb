class CreateHelloWorlds < ActiveRecord::Migration[5.2]
  def change
    create_table :hello_worlds do |t|
      t.string :country
      t.string :hello
      t.integer :priority
      t.string :image

      t.timestamps
    end
    add_index :hello_worlds, :country, unique: true
  end
end
