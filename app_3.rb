# require 'bundler'
# Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

#Display the game title
puts "-"*53 + "\n"+ "|Welcome on board - Let the Battle begin - V.3.0 !   |" + "\n" + "| Le but du jeu : être le dernier survivant 8-)    |" + "\n" + "-"*53 + "\n"

#The user create the game using his name
puts "Bonjour beau guerrier !"
print "Quel est ton nom ? > "
my_game = gets.chomp

game = Game.new(my_game) #Game is created... This is SPARTAAAAA... again

while game.is_still_ongoing?

  #Show the user his information
  game.show_players

  #Show the user the menu
  game.menu

  #The user says what he wants to do && actions are made #Power!!!!!!!!!!!
  game.menu_choice

  #The Empire counter attack
  game.enemies_attack

  #End of the round
  puts "\n-------------------Fin du tour -----------------------\n"
  print "Appuyer sur un touche pour continuer> "
  gets.chomp

end

game.end


#binding.pry
