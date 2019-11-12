require 'tty-prompt'
require 'audio-playback'

class Level < ActiveRecord::Base
    has_many :attempts
    has_many :users, through: :attempts

    Prompt = TTY::Prompt.new

    def self.fail
        puts " UH-OH YOU FAILED"
        
        sleep (3)
        
        input = Prompt.select("Try agian?", %w(Yes No))
            
        if input == "Yes"
            return "Try again"
        else
            return "Exit"
        end
        
    end  

    def self.level_1_stage_1
        puts "STAGE 1!"
        sleep (2)
        puts "There's a Koopa!"
        sleep (2)
        puts "You can defeat it by jumping, burning, freezing, eating, spinning"
    end

    def self.level_1_stage_2
        puts "STAGE 2!"
        sleep (2)
        puts "There's a ditch!"
        sleep (2)
        puts "You must jump over the ditch"
    end

    def self.level_1_stage_3
        
        
        puts "STAGE 3!"
        sleep (2)
        puts "There's BOWSER!"
        sleep (2)
        puts "You can defeate BOWSER by freezing him in place, then spinning"
    end





end
