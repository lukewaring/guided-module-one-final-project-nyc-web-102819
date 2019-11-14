require 'tty-prompt'
require 'audio-playback'
require 'catpix'

class Level < ActiveRecord::Base
    has_many :attempts
    has_many :users, through: :attempts

    Prompt = TTY::Prompt.new

    def self.fail
        slow_print_message("UH-OH YOU FAILED 😢", 0.05)
        puts ""
        puts " "
        sleep (3)
        input = Prompt.select("Try again?", %w(Yes No))
        if input == "Yes"
            return "Try again"
        else
            return "Exit"
        end
    end  

    def self.level_1_stage_1
        puts "STAGE 1".colorize(:magenta)
        puts ""
        sleep (2)
        slow_print_message("There's a Koopa!", 0.05)
        puts ""
        puts " "
        sleep (2)
        slow_print_message("You can defeat it by jumping, burning, freezing, eating or spinning", 0.05)
        puts " "
    end

    def self.level_1_stage_2
        puts "STAGE 2".colorize(:magenta)
        puts ""
        sleep (2)
        slow_print_message("There's a ditch!", 0.05)
        puts ""
        puts " "
        sleep (2)
        slow_print_message("You must jump over the ditch", 0.05)
        puts " "
    end

    def self.level_1_stage_3
        puts "STAGE 3".colorize(:magenta)
        puts ""
        sleep (2)
        slow_print_message("There's BOWSER! He's terrifying 😱".colorize(:red), 0.05)
        puts " "
        puts " "

        Catpix::print_image "./photos/bowser.jpg",
            :limit_x => 1,
            :limit_y => 1

        puts " "
        puts " "
        sleep (2)
        slow_print_message("You can defeat BOWSER by freezing him in place, then spinning", 0.05)
        puts " "
    end
  
    def self.level_2_stage_1
        puts "STAGE 1".colorize(:magenta)
        puts ""
        sleep (2)
        slow_print_message("There's a Bullet Bill!", 0.05)
        puts ""
        puts " "
        sleep (2)
        slow_print_message("You must duck under Bullet Bill", 0.05)
        puts " "
    end
    def self.level_2_stage_2
        puts "STAGE 2".colorize(:magenta)
        puts ""
        sleep (2)
        slow_print_message("There's a Charging Chuck!", 0.05)
        puts ""
        puts " "
        sleep (2)
        slow_print_message("You can defeat Charging Chuck by burning him", 0.05)
        puts " "
    end
    def self.level_2_stage_3
        puts "STAGE 3".colorize(:magenta)
        puts ""
        sleep (2)
        slow_print_message("There's DONKEY KONG! 🦍".colorize(:red), 0.05)
        puts " "
        puts " "

        Catpix::print_image "./photos/donkey_kong.png",
            :limit_x => 1,
            :limit_y => 1

        puts " "
        puts " "
        sleep (2)
        slow_print_message("You can defeat DONKEY KONG by burning him, then eating a nearby Koopa and launching a shell", 0.05)
        puts " "
    end

    def self.slow_print_message(message,speed)
        message.each_char do |x|
            sleep (speed); print x
        end
    end
end
