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

unless PostCollection.where(title: "Blog").first
  puts "** Create Simple Blog Post Collection **"
  blog = PostCollection.create! :title => "Blog"
end

unless PostTemplate.where(title: "Blog Post").first
  puts "** Create Simple Blog Post Template **"
  template = PostTemplate.create! :title => "Blog Post", :post_collection => blog

  title_field = TemplateField.create! :post_template => template, :label => "title", :field_type => "text"
  content_field = TemplateField.create! :post_template => template, :label => "content", :field_type => "textblock"
end