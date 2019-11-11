class User < ActiveRecord::Base
    has_many :attempts
    has_many :levels, through: :attempts
end

