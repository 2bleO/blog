class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :photo, default: 'https://images.pexels.com/photos/247791/pexels-photo-247791.png?auto=compress&cs=tinysrgb&dpr=1&w=500'
      t.text :bio
      t.integer :posts_counter

      t.timestamps
    end
  end
end
