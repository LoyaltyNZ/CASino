module CASino::JwtProcessor
  extend ActiveSupport::Concern

  def self.refresh_jwt!(user)
    return unless defined? ConsoleUtil

    jwt_data = ConsoleUtil::JsonWebToken.unsafe_decode(user.extra_attributes[:jwt])
    return unless jwt_data && ConsoleUtil::JsonWebToken.jwt_expired?(jwt_data)


    new_exp = 1.minute.from_now.utc.to_i
    jwt_data.merge!(exp: new_exp)

    user.extra_attributes[:jwt] = ConsoleUtil::JsonWebToken.encode(jwt_data)
    user.save
  end
end
