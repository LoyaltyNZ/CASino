# This is a dummy class used for testing
# The actual class should be defined at the service implementing CASino
# e.g: console_sso

module CASino::UserJwtProcessor
  def self.refresh_jwt!(casino_user)
    casino_user.extra_attributes[:jwt] = "refresh!"
    casino_user.save
  end
end
