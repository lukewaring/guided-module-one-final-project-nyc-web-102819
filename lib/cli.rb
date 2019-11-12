require 'tty-prompt'
require 'audio-playback'

class CommandLineInterface
    Prompt = TTY::Prompt.new
    @@current_user = nil
    @@current_level = nil
    @@character = ""
    @@item_1 = ""
    @@item_2 = ""
    @@attempt = nil


    def run
        greet
        check_for_account
        game_selection
    end

    def game_selection
        choose_level
        choose_character
        choose_item_1
        choose_item_2
        create_attempt
        play_game
    end


    def greet
        puts "Welcome to Super Mario CLI!" 
        @playback = AudioPlayback.play("/Users/lukewaring2/Development/project_1/module-one-final-project-nyc-web-102819/sounds/open.wav")

        sleep (2)
        
    end

    def check_for_account
        input = Prompt.select("Do you have an account?", %w(Yes No))
            
        if input == "Yes"
            login
        else
            create_account
        end
        
        puts "Welcome #{@@current_user.name}"
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
        character = Prompt.select("Choose a character") do |menu|
            menu.choice "Mario - duck"
            menu.choice "Luigi - jump"
          end
        @@character = character
    end

    def choose_item_1
        item_1 = Prompt.select("Choose your first item") do |menu|
            menu.choice "fire flower - fire"
            menu.choice "ice flower - ice"
            menu.choice "Yoshi - eat"
            menu.choice "cape - spin"
          end
        @@item_1 = item_1
    end

    def choose_item_2
        item_2 = Prompt.select("Choose your second item") do |menu|
            menu.choice "fire flower - fire"
            menu.choice "ice flower - ice"
            menu.choice "Yoshi - eat"
            menu.choice "cape - spin"
          end
        @@item_2 = item_2
    end

    def create_attempt
        @@attempt = Attempt.create(user_id: @@current_user.id, level_id: @@current_level.id, character: @@character, item_1: @@item_1, item_2: @@item_2, complete: 0)
        puts "Get ready for #{@@current_level.name}"
    end

    def play_game
        sleep (3)
        Level.level_1_stage_1
        sleep (3)
        level_1_stage_1_test
        sleep (3)
        Level.level_1_stage_2
        sleep (3)
        level_1_stage_2_test
        sleep (3)
        Level.level_1_stage_3
        sleep (3)
        level_1_stage_3_test
        sleep (3)
                
    end


    def level_1_stage_1_test
        #puts "You can defeated the by jumping, burning, freezing, eating, spinning"
        if @@character == "Luigi - jump" || @@item_1 == "fire flower - fire" || @@item_1 == "ice flower - ice" || @@item_1 == "Yoshi - eat" || @@item_1 == "cape - spin"|| @@item_2 == "fire flower - fire" || @@item_2 == "ice flower - ice" || @@item_2 == "Yoshi - eat" || @@item_2 == "cape - spin"
            puts "You defeated the Koopa"
            sleep (2)
            puts "Proceed to Stage 2!"
        else
            puts "You couldn't defeat the Koopa"
            game_fail
        end
    
    end

    def level_1_stage_2_test
        #puts "You must jump over the ditch"
        if @@character == "Luigi - jump" 

            puts "You jumped over the ditch"
            sleep (2)
            puts "Proceed to Stage 3!"
        else
            puts "You couldn't jump over the ditch."
            sleep (1)
            game_fail
        end
    
    end

    def level_1_stage_3_test
        
        #@playback = AudioPlayback.play("/Users/lukewaring2/Development/project_1/module-one-final-project-nyc-web-102819/sounds/bowser.wav")
     
        #puts "You can defeate BOWSER by freezing him in plase, then spinning"
        if (@@item_1 == "ice flower - ice" &&  @@item_2 == "cape - spin") || (@@item_1 == "cape - spin" && @@item_2 == "ice flower - ice")

            puts "You defeated BOWSER"
            sleep (2)
            game_win
        else
            puts "You couldn't defeat BOWSER."
            sleep (1)
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
        puts "CONGRATS, YOU RESCUED THE PRINCESS"
        
        sleep (3)
        

        input = Prompt.select("Try again?", %w(Yes No))
            
        if input == "Yes"
            game_selection
        else
            exit_game
        end
        
    end

    def exit_game
        puts "Thank you for playing"
        run
    end

end
