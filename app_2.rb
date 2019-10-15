# require 'bundler'
# Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

#Display the game title
puts "-"*48 + "\n"+ "|Bienvenue sur 'FORTNITE VERSION CHEATÉE V2.0!  |" + "\n" + "|Le but du jeu est d'être le dernier survivant !|" + "\n" + "-"*48 + "\n"

#The user create his persona
puts "Here comes a new challenger !"
print "What is your name? > "
name = gets.chomp
human_player1 = HumanPlayer.new(name)
puts "Bienvenue à FORTNITE Cheaté #{human_player1.name}\n"

#Create player1 enemies .... This is SPARTAAAAA!
enemies = [Player.new("Josiane"), Player.new("José")]
puts "Voici tes adversaires :"
puts "À ta droite #{enemies[0].name}"
puts "À ta gauche #{enemies[1].name}\n"


while human_player1.life_points > 0 && (enemies[0].life_points > 0 || enemies[1].life_points > 0)

  #Show the user his information
  puts "Mon état :"
  puts "#{human_player1.show_state}"

  #Options for the player to do
  puts "Quelle action veux-tu effectuer ?\n"
  puts "a - chercher une meilleure arme"
  puts "s - chercher à se soigner \n"
  puts "Attaquer un joueur en vue :"
  enemies.each_with_index {|enemy, index| puts "#{index} - "+ enemy.show_state_v2 } #Show all the enemies there

  #Get the user choice (he has to put a correct choice)
  print "choix > "
  choice = gets.chomp
  while (!['a','s'].include?(choice.downcase) && (choice != '0' && choice.to_i >= enemies.length))
    print "Action non reconnue. Essaie encore >"
    choice = gets.chomp
  end

  case
  when choice.downcase == 'a' #If the user wants to get another weapon
    human_player1.search_weapon
  when choice.downcase == 's' #If the user wants to get healed
    human_player1.search_health_pack
  else
    human_player1.attacks(enemies[choice.to_i]) #The user attacks the right enemy
  end

  puts "\nLes autres joueurs t'attaquent !"

  enemies.each { |enemy|
    enemy.attacks(human_player1) if enemy.life_points > 0 #If the enemy is still alive, he attacks the player
  }

  puts "\n-------------------Fin du tour -----------------------\n"
  print "Appuyer sur une touche pour continuer > "
  gets.chomp

end

if human_player1.life_points > 0
  puts "\n\n------------------- THE END : BRAVO ! TU AS GAGNE !-----------------------"
else
  puts "\n\n------------------- THE END : Loser ! Tu as perdu !-----------------------"
end
