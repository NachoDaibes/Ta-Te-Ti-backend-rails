class BoardsController < ApplicationController
    before_action :set_board, only: [:new_move, :new_game]
    before_action :check_players, only: [:new_move]

    def new_game
        player2 = User.where(inqueue: true).first 
        if player2.present?
            player2.inqueue = false
            player2.save
            @board.user2 = player2
            @board.save
            render status: 200, json: {board: @board}
        elsif player2 = User.where(inqueue: false).first
            player2.inqueue = true
            player2.save
            render status: 400, json:{message: "There isn't any player waiting"}
        end
    end

    def create
        if current_user.present?
            if current_user.inqueue = true
                current_user.update(inqueue: false)
                board = Board.new
                board.user1 = current_user
                board.save
                render status: 200, json:{board: board}
            else 
                render status: 400, json:{message: "There isn't any players in queue"}
            end
        else 
            render status: 400, json:{message: "There isn't any current player"}
        end 
    end

    def new_move
        row = params[:row]
        cells_user1 = @board.cells_user1.split(",")
        cells_user2 = @board.cells_user2.split(",")
        if @board.winner == @board.user1 || @board.winner == @board.user2 
            render status: 400, json:{message: "There is a winner"}
        elsif cells_user1.include?("#{row}") || cells_user2.include?("#{row}")
            render status: 400, json:{message: "You can't move there"}
        else
            if @board.turn == "x"
                cells_user1.push("#{row}")
                
                @board.turn = "o"
            else
                cells_user2.push("#{row}")
                @board.turn = "x"
            end
            @board.cells_user1 = cells_user1.join(",")   
            @board.cells_user2 = cells_user2.join(",")  
            if @board.check_winner(cells_user1) == true
                @board.set_winner(@board.user1)
            elsif @board.check_winner(cells_user2) == true
                @board.set_winner(@board.user2)
            end
            @board.save
            render status: 200, json:{board: @board}
        end
    end

    def index
        @boards = Board.all
        render status: 200, json:{boards: @boards}
    end

    private
    def board_params
        params.require(:board).permit(:winner, :turn, :board, :row)
    end

    def set_board
        @board = Board.find_by(id: params[:id])
        if @board.blank?
            render status: 400, json:{message: "Board not found"}
        end
    end

    def check_players
        if @board.user1.blank? || @board.user2.blank?
            render status: 400, json:{message: "One player is missing"}
        end
    end
end
