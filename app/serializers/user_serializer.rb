class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :user_roles
  def user_roles
    self.object.roles.pluck(:name)
  end
end
