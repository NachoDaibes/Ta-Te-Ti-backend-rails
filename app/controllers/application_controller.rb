class ApplicationController < ActionController::API
    
    def current_user
        token = request.headers["Authorization"]
        @current_user = User.find_by(token: token)  
    end

    def current_board
        @current_board = Board.find_by(id: params[:id])
    end
end
