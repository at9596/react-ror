class ApplicationController < ActionController::API
    before_action :aunthenticate_request
    include Pagy::Backend
    include JsonWebToken
    private
    def aunthenticate_request
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      decoded = jwt_decode(header)
      @current_user = User.find_by(id: decoded['user_id'])
    end
end
