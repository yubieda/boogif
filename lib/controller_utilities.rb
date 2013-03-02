# This module makes several methods for general purpouse activities

module ControllerUtilities
  
  def self.generate_random_password
    return SecureRandom.hex(3)
  end
end