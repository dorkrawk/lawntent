class PostImage < ActiveRecord::Base

  belongs_to :post
  belongs_to :template_field

  has_attached_file :image,
                    :styles => { :medium => '200x200#', :small => '100x100#', :thumb => '50x50#', :tiny => '30x30#'}

  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/jpg', 'image/gif', 'image/png', 'image/pjpeg', 'image/x-png']                      
  validates :post, presence: true
  validates :template_field, presence: true
end
