class ImageSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :title, :image_url

  def image_url
    rails_blob_path(self.object.image_post, only_path: true)
  end

end
