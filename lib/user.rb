class User < ActiveRecord::Base
    has_many :attempts
    has_many :levels, through: :attempts

    def attempts
        Attempt.all.select do |attempt|
            attempt.user_id == self.id
        end
    end

    def wins
        self.attempts.select do |attempt|
            attempt.complete == true
        end
    end     

    def record
     puts "Your record... Attempts: #{self.attempts.count}, Wins: #{self.wins.count}".colorize(:yellow)   
    end
end
