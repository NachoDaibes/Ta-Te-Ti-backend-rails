class UsersController < ApplicationController
    def login
        user = User.find_by(user_params)
        if user.present?
            user.inqueue = true
            token = user.token
            user.save
            render status: 200, json:{token: user.token}
        else
            render status: 400, json:{message: "Not found"}
        end
    end

    def create 
        if params[:password] == params[:password2]
            user = User.new(user_params)
            user.inqueue = false
            if user.save
                render status: 200, json:{user: user.token}
            else
                render status: 400, json:{error: user.errors.details}
            end
        else
            render status: 400, json:{message: "Diferent passwords"}
        end
    end

    def current
        render status: 200, json:{current_user: current_user}
    end

    def index
        @users = User.all 
        render status: 200, json:{users: @users}
    end

    private
    def user_params
        params.require(:user).permit(:name, :password, :inqueue)
    end
end
