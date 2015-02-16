class Post < ActiveRecord::Base

  has_many :field_values
  has_one :post_template
  belongs_to :user

  def get_content
    content = {}
    content[:post_id] = id
    content[:author] = user.email
    field_values.each do |v|
      content[v.template_field.label] = v.value
    end
    content[:created_at] = created_at

    content
  end
end
