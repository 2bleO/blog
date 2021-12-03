# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
random = Random.new
user_qty = random.rand(2..5)

user_qty.times do |i|
  user = User.create(name: "TestUser#{i + 1}", bio: "Hello Im User#{i + 1}.",
                     email: "test@user#{i + 1}.com", password: "testu#{i + 1}",
                     password_confirmation: "testu#{i + 1}", confirmed_at: Date.today)

  post_qty = random.rand(3..5)
  post_qty.times do |j|
    Post.create(title: "Post ##{j + 1} of #{user.name}", text: "This is post #{j + 1} of #{user.name}",
                author: user)
  end
end
