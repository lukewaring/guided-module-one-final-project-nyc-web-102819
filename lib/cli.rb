require 'tty-prompt'

class CommandLineInterface
    Prompt = TTY::Prompt.new


    def run
        greet
        check_for_account
        


    end

    

    def greet
        puts "Welcome to Super Mario CLI!"
    end

    def check_for_account
        input = Prompt.select("Do you have an account?", %w(Yes No))
        
        
        if input == "Yes"
            login
        else
            create_account
        end 

    end
    
    def login
        # username = gets_username
        # password = gets_password

        current_user = User.all.find_by(name: gets_username, password: gets_password)
        puts current_user

    end

    def create_account
        puts "Please create your account"
        # username = gets_username
        # password = gets_password

        current_user = User.all.create(name: gets_username, password: gets_password)
        puts current_user
    end


    

    def gets_username
        puts "Username:"
        gets.chomp
    end
    def gets_password
        Prompt.mask("Password:")
        
    end
 


end
