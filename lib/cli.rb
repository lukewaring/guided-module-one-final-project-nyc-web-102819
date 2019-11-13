require 'tty-prompt'
require 'audio-playback'
require 'figlet'
require 'colorize'

class CommandLineInterface
    Prompt = TTY::Prompt.new
    @@current_user = nil
    @@current_level = nil
    @@character = ""
    @@item_1 = ""
    @@item_2 = ""
    @@attempt = nil

    def run
        banner
        puts ""
        greet
        puts ""
        check_for_account
        game_selection
    end

    def game_selection
        choose_level
        puts ""
        choose_character
        puts ""
        choose_item_1
        puts ""
        choose_item_2
        puts ""
        create_attempt
        puts ""
        play_game
    end

    def banner
        puts ""
        puts "    ____                          __  __            _          ____ _     ___   ".colorize(:red)
        puts '   / ___| _   _ _ __   ___ _ __  |  \/  | __ _ _ __(_) ___    / ___| |   |_ _|  '.colorize(:red)
        puts '   \___ \| | | |  _ \ / _ \  __| | |\/| |/ _` |  __| |/ _ \  | |   | |    | |   '.colorize(:red)
        puts "    ___) | |_| | |_) |  __/ |    | |  | | (_| | |  | | (_) | | |___| |___ | |   ".colorize(:red)
        puts '   |____/ \__,_| .__/ \___|_|    |_|  |_|\__,_|_|  |_|\___/   \____|_____|___|  '.colorize(:red)
        puts "               |_|                                                              ".colorize(:red)
    end

    def greet
        @playback = AudioPlayback.play("/Users/lukewaring2/Development/project_1/module-one-final-project-nyc-web-102819/sounds/open.wav")
        
        #slow_print_message(message,speed)
        slow_print_message("Welcome to Super Mario CLI!",0.1) 
        sleep (1)
        puts ""
    end

    def check_for_account
        input = Prompt.select("Do you have an account?", %w(Yes No))
        puts ""
        if input == "Yes"
            login
        else
            create_account
        end
        puts ""
        puts "Welcome, #{@@current_user.name}"
        puts ""
        puts @@current_user.record
    end
    
    def login
        @@current_user = User.all.find_by(name: gets_username, password: gets_password)
    end

    def create_account
        puts "Please create your account"
        @@current_user = User.all.create(name: gets_username, password: gets_password)
    end

    def gets_username
        puts "Username:"
        gets.chomp
    end

    def gets_password
        puts ""
        Prompt.mask("Password:")
    end

    def choose_level
        level_select = Prompt.select("Choose a level") do |menu|
            menu.choice "Yoshi's Island"
          end
        if level_select == "Yoshi's Island"
            @@current_level = Level.find_by(name: "Yoshi's Island") 
        end
    end

    def choose_character
        character = Prompt.select("Choose a character. The character's special ability is listed after the hypen") do |menu|
            menu.choice "Mario - duck".colorize(:red)
            menu.choice "Luigi - jump".colorize(:green)
          end
        @@character = character
    end

    def choose_item_1
        item_1 = Prompt.select("Choose your first item") do |menu|
            menu.choice "fire flower - burn".colorize(:red)
            menu.choice "ice flower - freeze".colorize(:cyan)
            menu.choice "Yoshi - eat".colorize(:green)
            menu.choice "cape - spin".colorize(:yellow)
          end
        @@item_1 = item_1
    end

    def choose_item_2
        item_2 = Prompt.select("Choose your second item") do |menu|
            menu.choice "fire flower - burn".colorize(:red)
            menu.choice "ice flower - freeze".colorize(:cyan)
            menu.choice "Yoshi - eat".colorize(:green)
            menu.choice "cape - spin".colorize(:yellow)
          end
        @@item_2 = item_2
    end

    def create_attempt
        @@attempt = Attempt.create(user_id: @@current_user.id, level_id: @@current_level.id, character: @@character, item_1: @@item_1, item_2: @@item_2, complete: 0)
        slow_print_message("Get ready for #{@@current_level.name}",0.05)
        puts " "
        puts " "
        sleep (2)
    end

    def play_game
        Level.level_1_stage_1
        puts ""
        sleep (3)
        level_1_stage_1_test
        sleep (3)
        Level.level_1_stage_2
        puts ""
        sleep (3)
        level_1_stage_2_test
        sleep (3)
        Level.level_1_stage_3
        puts ""
        sleep (3)
        level_1_stage_3_test
        sleep (3)      
    end

    def level_1_stage_1_test
        if @@character == "Luigi - jump".colorize(:green) || @@item_1 == "fire flower - burn".colorize(:red) || @@item_1 == "ice flower - freeze".colorize(:cyan) || @@item_1 == "Yoshi - eat".colorize(:green) || @@item_1 == "cape - spin".colorize(:yellow) || @@item_2 == "fire flower - burn".colorize(:red) || @@item_2 == "ice flower - freeze".colorize(:cyan) || @@item_2 == "Yoshi - eat".colorize(:green) || @@item_2 == "cape - spin".colorize(:yellow)
            puts "You defeated the Koopa".colorize(:green)
            puts ""
            sleep (2)
            slow_print_message("Proceed to Stage 2!", 0.05)
            puts ""
            puts ""
            puts " "
        else
            puts "You couldn't defeat the Koopa".colorize(:red)
            game_fail
        end
    end

    def level_1_stage_2_test
        if @@character == "Luigi - jump".colorize(:green) 
            puts "You jumped over the ditch".colorize(:green)
            puts ""
            sleep (2)
            slow_print_message("Proceed to Stage 3!", 0.05)
            puts " "
            puts " "
            puts " "
            
        else
            puts "You couldn't jump over the ditch".colorize(:red)
            puts " "
            game_fail
        end
    end

    def level_1_stage_3_test
        if (@@item_1 == "ice flower - freeze".colorize(:cyan) &&  @@item_2 == "cape - spin".colorize(:yellow)) || (@@item_1 == "cape - spin".colorize(:yellow) && @@item_2 == "ice flower - freeze".colorize(:cyan))
            puts "You defeated BOWSER and rescued the princess!".colorize(:green)
            puts ""
            sleep (2)
            game_win
        else
            puts "You couldn't defeat BOWSER".colorize(:red)
            sleep (1)
            puts " "
            game_fail
        end
    end

    def game_fail
        # Level.fail
        @playback = AudioPlayback.play("/Users/lukewaring2/Development/project_1/module-one-final-project-nyc-web-102819/sounds/fail.wav")
            sleep (2)
        if Level.fail == "Try again"
            game_selection
        else
            exit_game
        end
    end

    def game_win
        @playback = AudioPlayback.play("/Users/lukewaring2/Development/project_1/module-one-final-project-nyc-web-102819/sounds/pass.wav")
        
        @@attempt.complete = 1
        @@attempt.save

        puts '   ____ ___  _   _  ____ ____      _  _____ ____  '
        puts '  / ___/ _ \| \ | |/ ___|  _ \    / \|_   _/ ___| '
        puts ' | |  | | | |  \| | |  _| |_) |  / _ \ | | \___ \ '
        puts ' | |__| |_| | |\  | |_| |  _ <  / ___ \| |  ___) | '
        puts '  \____\___/|_| \_|\____|_| \_\/_/   \_\_| |____/ '
        puts ""
        puts ""
        sleep (3)

        input = Prompt.select("Try again?", %w(Yes No))
        puts " "
        if input == "Yes"
            game_selection
        else
            exit_game
        end 
    end

    def exit_game
        puts " "
        slow_print_message("Thank you for playing", 0.05)
        puts ""
        exit
    end
    
    def slow_print_message(message,speed)
        message.each_char do |x|
            sleep (speed); print x
        end
    end
end
