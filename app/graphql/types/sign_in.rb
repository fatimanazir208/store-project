module Mutations
  class SignUp < BaseMutation

    # insert attribute accessor here
    # insert arguments here
    field :sign_in, Types::LoginType, null: false do
      argument :email, String, required: true
      argument :password, String, required: true
    end

    def sign_in(email:, password:)
      unless email || password
        error = "Provide email or password"
      end
      user = User.find_by_email(email)
      
      unless user
        error = "Invlaid email" 
      end
      
      if user.valid_password?(password)
        crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
        token = crypt.encrypt_and_sign("user-id:#{ user.id }")
        session[:token] = token
      else
        error = "Invlaid password"
      end
      {
        user: error ? nil : user,
        token: error ? nil : token,
        error: error
      }
    end
  end
end