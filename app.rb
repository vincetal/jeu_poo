# require 'bundler'
# Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'


puts "BIENVENUE DANS LA VERSION CHEATÉE DE FORTNITE V1.0\n\n"

#Players presentation
player1 = Player.new("Josiane")
# binding.pry
puts "À ma droite #{player1.name}"
player2 = Player.new("José")
puts "À ma gauche #{player2.name}\n"

#They will fight till the death of one
while player1.life_points > 0 && player2.life_points > 0

  #Players state
  puts "\nVoici l'état de chaque joueur :"
  puts "#{player1.show_state}\n#{player2.show_state}"
  #Fight
  puts "Passons à la phase d'attaque : ---------------"
  player1.attacks(player2) #Josiane attacks José
  break if player2.life_points <= 0 #If player 2 is already dead, he cannot attack
  player2.attacks(player1) #José attacks Josiane
  puts "\n-------------------Fin de la phase d'attaque -----------------------"

end
puts "\n\n------------------- THE END (so sad...)-----------------------"
