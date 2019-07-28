class NewsFeedSerializer < ActiveModel::Serializer
  belongs_to :postable, polymorphic: true
  belongs_to :created_by, class_name: 'User'

  attributes :id, :postable, :created_at, :created_by
end
