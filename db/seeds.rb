# Default configuration for regural users
reg_config = {
  bio: 'A user profile is a collection of settings and information associated with a user. It contains critical information that is used to identify an individual, such as their name, age, portrait photograph and individual characteristics such as knowledge or expertise.',
  photo: '_author.png',
  password: 'dev@123'
}
# Default configuration for admin users.
# Crafted from :reg_config and adjusted to its standards
admin_config = { **reg_config, role: 'admin' }

# Create admin users
User.create(name: 'John Smith', email: 'johnsmith@test.email', **admin_config)  #verified
User.create(name: 'Albert Dodge', email: 'albertdodge@test.email', **admin_config)

# Create regular users
User.create(name: 'Edouard Loth', email: 'lotheddy@test.email', **reg_config)
User.create(name: 'Eric James', email: 'jimmy@test.email', **reg_config)
User.create(name: 'Stephen Salvator', email: 'stephen@test.email', **reg_config)
User.create(name: 'Damon Salvator', email: 'damon@test.email', **reg_config)  # verified
User.create(name: 'Helene Gilbert', email: 'helene@test.email', **reg_config)

# Create posts
(1..10).each do |j|
  Post.create(author_id: User.ids.sample, title: "TEST_TITLE_#{j}", text: "TEST_TEXT_#{j}")
end

# Create comments
(1..50).each do |j|
  Comment.create(author_id: User.ids.sample, post_id: Post.ids.sample, text: "TEST_TEXT_#{j}")
end

# Create likes
(1..80).each do |j|
  Like.create(author_id: User.ids.sample, post_id: Post.ids.sample)
end

