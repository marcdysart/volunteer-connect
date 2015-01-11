require 'faker'

# Create Users
3.times do
  user = User.new(

  name:     Faker::Name.name,
  email:    Faker::Internet.email,
  password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

# Note: by calling `User.new` instead of `create`,
# we create an instance of User which isn't immediately saved to the database.

# The `skip_confirmation!` method sets the `confirmed_at` attribute
# to avoid triggering an confirmation email when the User is saved.

# The `save` method then saves this User to the database.



# Create Posts
10.times do
  post = Post.create!(
  title:  Faker::Lorem.sentence,
  body:   Faker::Lorem.paragraph
  )

end
posts = Post.all

# Create Comments
30.times do
  Comment.create!(
  # user: users.sample,   # we have not yet associated Users with Comments
  post:   posts.sample,
  body:   Faker::Lorem.sentence
  )
end

# Create an admin user
admin = User.new(
name:     'Admin User',
email:    'admin@example.com',
password: 'helloworld'
)
admin.skip_confirmation!
admin.save!


# Create a member
member = User.new(
name:     'Member User',
email:    'member@example.com',
password: 'helloworld'
)
member.skip_confirmation!
member.save!


puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
