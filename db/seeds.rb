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


# Create Locations
10.times do
  location = Location.new(
  name: Faker::Address.city
  )
  location.save!
end
locations = Location.all

# Create People
10.times do
  person = Person.new(
  name: Faker::Name.name
  )
  person.save!
end
people = Person.all

# Create Posts
10.times do
  post = Post.create!(
  user:   users.sample,
  title:  Faker::Lorem.sentence,
  body:   Faker::Lorem.paragraph,
  locations: [locations.sample,locations.sample],
  people: [people.sample,people.sample]
  )

end
posts = Post.all



# Create Comments
30.times do
  Comment.create!(
  user: users.sample,
  post:   posts.sample,
  body:   Faker::Lorem.sentence
  )
end

3.times do
  extra_locations = Location.create!(
  name:   Faker::Address.city,
  posts: [posts.sample,posts.sample]
  )

end

# Create an admin user
admin = User.new(
name:     'Admin User',
email:    'admin@example.com',
password: 'helloworld',
role: 'admin'
)
admin.skip_confirmation!
admin.save!


# Create a member
member = User.new(
name:     'Member User',
email:    'member@example.com',
password: 'helloworld',
role: 'member'
)
member.skip_confirmation!
member.save!


puts "Seed finished"
puts "#{Location.count} locations created"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
