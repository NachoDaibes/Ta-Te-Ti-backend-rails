class User < ApplicationRecord
    has_one :board
    

    validates :name, uniqueness: true
    validates :name, :password,  presence: true

    before_create :set_token

    def set_token
        self.token = SecureRandom.uuid
    end
end
