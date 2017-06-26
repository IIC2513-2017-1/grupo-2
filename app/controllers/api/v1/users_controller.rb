module Api::V1
  class UsersController < ApiController
    before_action :authenticate

    def show
      unless (@current_user.id == params[:id]) || (@current_user.role.name == "admin")
        render( json: {} ) and return
      end
      @user = User.find(params[:id])
    end
  end
end
