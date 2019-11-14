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

    def win_percent
        win_percent = ((self.wins.count.to_f / self.attempts.count.to_f) * 100).round(2)
    end

    def self.all_win_percent
        array = User.all.collect { |u| (u.wins.count.to_f / u.attempts.count.to_f) * 100 }
    end

    def record
     puts "Your record... Attempts: #{self.attempts.count}, Wins: #{self.wins.count}".colorize(:yellow)   
    end
end
