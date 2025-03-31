module JsonWebToken
    SECRET_KEY = Rails.application.credentials.secret_key_base
    EXPIRATION_TIME = 24.hours.to_i
    # Encode the payload into a JWT token
    def jwt_encode(payload)
        payload[:exp] = Time.now.to_i + EXPIRATION_TIME
        JWT.encode(payload, SECRET_KEY)
    end
    
    # Decode the JWT token and return the payload
    def jwt_decode(token)
        body = JWT.decode(token, SECRET_KEY)[0]
        HashWithIndifferentAccess.new body
    end
end