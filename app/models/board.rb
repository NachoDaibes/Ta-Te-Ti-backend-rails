class Board < ApplicationRecord
    before_create :empty_board
    belongs_to :user1, class_name: "User"
    belongs_to :user2, class_name: "User", optional: true

    def empty_board
        self.cells_user1 = ""
        self.cells_user2 = ""
        self.winner = nil
        self.turn = "x"
    end

    def set_winner(player)
        self.winner = player.name
    end

    def check_winner(b)
        winner_cells = [["0","1","2"],["3","4","5"],["6","7","8"],["0","3","6"],
        ["1","4","7"],["2","5","8"],["0","4","8"],["2","4","6"]]
        winner_cells.map{|x| if(b.to_set.superset?(x.to_set) == true)     
        return true
        end}
    end
end
