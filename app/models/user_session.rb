class UserSession
  include ActiveModel::Translation
  include ActiveModel::Conversion
  include ActiveModel::Validations

  validate :validate_authentication

  attr_accessor :login, :password
  attr_reader :user

  def initialize(*attributes)
    attributes = attributes.first || { :login => nil, :password => nil }
    @login, @password = attributes[:login], attributes[:password]
  end

  def persisted?
    false
  end

  def validate_authentication
    if user.nil?
      errors.add :base, I18n.t('activemodel.errors.models.user_session.authentication')
    end
  end

  def user
    @user ||= User.where(:login => login, :password => password).first
  end
end
