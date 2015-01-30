require 'faker'

# Create Users
5.times do
  user = User.new(

  name:     Faker::Name.name,
  email:    Faker::Internet.email,
  password: Faker::Lorem.characters(10),
  aboutme:  Faker::Lorem.sentence,
  avatar: Faker::Avatar.image
  )
  user.skip_confirmation!
  user.save!

end


# Create a member
member = User.new(
name:     'Member User',
email:    'member@example.com',
password: 'helloworld',
role: 'member',
aboutme: 'I am a regular member'
)
member.skip_confirmation!
member.save!

users = User.all

# Note: by calling `User.new` instead of `create`,
# we create an instance of User which isn't immediately saved to the database.

# The `skip_confirmation!` method sets the `confirmed_at` attribute
# to avoid triggering an confirmation email when the User is saved.

# The `save` method then saves this User to the database.


# Create Locations
10.times do
  location = Location.new(
  name: Faker::Address.city,
  latitude: 10.3794261,
  longitude: -9.3050495
  )
  location.save!
end

labe = Location.new(
  name: 'Labe',
  latitude: 11.3196146,
  longitude: -12.2898817
)
labe.save!

conakry = Location.new(
  name: 'Conakry',
  latitude: 9.6355819,
  longitude: -13.5787382
)
conakry.save!

locations = Location.all

# Create People not linked to a User
5.times do
  person = Person.new(
  name: Faker::Name.name
  )
  person.save!
end

# Create People linked to a User
counter = 0
6.times do
  counter = counter+1
  person = Person.new(
  user: users.find(counter),
  name: users.find(counter).name
  )
  person.save!
end
people = Person.all

# Create Dates
10.times do
  period = Period.new(
  start: Faker::Date.backward(2000)
  )
  period.save!
end
periods = Period.all

# Create Posts
10.times do
  post = Post.create!(
  user:   users.sample,
  title:  Faker::Lorem.sentence,
  body:   Faker::Lorem.paragraph,
  locations: [locations.sample,locations.sample],
  people: [people.sample,people.sample],
  periods: [periods.sample]
  )

  # set the created_at to a time within the past year
 post.update_attributes!(created_at: rand(10.minutes .. 1.year).ago)
 post.update_rank

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


puts "Seed finished"
puts "#{Location.count} locations created"
puts "#{Person.count} people created"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
