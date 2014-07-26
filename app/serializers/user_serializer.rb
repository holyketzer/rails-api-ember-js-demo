class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :token

  def token
     token = Doorkeeper::AccessToken.where(resource_owner_id: object.id).order('created_at asc').limit(1).first
     token.token if token
  end
end