unless User.where(email: "admin@lawntent.com").first
  puts "** Adding Admin User **"
  user = User.create! :email => 'admin@lawntent.com', :password => 'password', :password_confirmation => 'password'
  user.toggle!(:admin)
  puts "(Admin user #{user.email} added with simple password: 'password')"
  puts ""
end
user = User.where(email: "admin@lawntent.com").first

##################
# Build Blog Post template / Blog
##################

unless PostTemplate.where(title: "Blog Post").first
  puts "** Create Simple Blog Post Template **"
  template = PostTemplate.create! :title => "Blog Post"

  title_field = TemplateField.create! :post_template => template, :label => "title", :field_type => "text"
  content_field = TemplateField.create! :post_template => template, :label => "content", :field_type => "textblock"

  template.update_attribute(:descriptor_field_id, title_field.id)
end
blog_post_template = PostTemplate.where(title: "Blog Post").first

unless PostCollection.where(title: "Blog").first
  puts "** Create Simple Blog Post Collection **"
  blog = PostCollection.create! :title => "Blog", :post_template => blog_post_template, :owner => user
end

##################
# Build Comic Post template / Comic
##################

unless PostTemplate.where(title: "Comic Post").first
  puts "** Create Simple Comic Post Template **"
  template = PostTemplate.create! :title => "Comic Post"

  title_field = TemplateField.create! :post_template => template, :label => "title", :field_type => "text"
  comic_field = TemplateField.create! :post_template => template, :label => "comic", :field_type => "image"
  description_field = TemplateField.create! :post_template => template, :label => "description", :field_type => "textblock"

  template.update_attribute(:descriptor_field_id, title_field.id)
end
comic_post_template = PostTemplate.where(title: "Comic Post").first

unless PostCollection.where(title: "Comic").first
  puts "** Create Simple Comic Post Collection **"
  comic = PostCollection.create! :title => "Comic", :post_template => comic_post_template, :owner => user
end
