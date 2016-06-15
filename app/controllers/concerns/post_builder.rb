module PostBuilder
  extend ActiveSupport::Concern

  def build_basic_content_json(params, content_json = {})
    params[:post][:field_values].each do |value_label, value|
      content_json[value_label.to_sym] = value
    end
    content_json
  end

  def handle_boolean_fields(params, content_json, template)
    template.template_fields.by_type(:boolean).each do |boolean_field|
      content_json[boolean_field.clean_label.to_sym] = params[:post][:field_values].keys.include?(boolean_field.clean_label)
    end
    content_json
  end

  def handle_image_fields(params, content_json, template)
    return content_json, [] unless params[:post][:images]
    post_images = params[:post][:images].map do |image_field, image_field_params|
      template_field = template.template_fields.where(label: image_field).first
      post_image = PostImage.new(image: image_field_params, template_field_id: template_field.id)
      content_json[image_field.to_sym] = {
        object_type: "image",
        image_url: post_image.image.url
      }
      post_image
    end
    return content_json, post_images
  end
end
