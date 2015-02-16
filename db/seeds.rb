# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
unless User.where(email: "admin@lawntent.com").first
  puts "** Adding Admin User **"
  user = User.create! :email => 'admin@lawntent.com', :password => 'password', :password_confirmation => 'password'
  user.toggle!(:admin)
  puts "(User #{user.email} added with simple password)"
  puts ""
end

puts "** Create Simple Blog Post Collection **"
blog = PostCollection.where(title: "Blog").first_or_create

puts "** Create Simple Blog Post Template **"
template = PostTemplate.where(title: "Blog Post", post_collection: blog).first_or_create
title_field = TemplateField.where(post_template: template, label: "title", field_type: "text").first_or_create
content_field = TemplateField.where(post_template: template, label: "content", field_type: "textblock").first_or_create