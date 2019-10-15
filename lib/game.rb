require_relative 'player'

class Game

  attr_accessor :human_player, :enemies
  #####################################################
  #Function that initialize the game with the players
  ######################################################
  def initialize(name_to_save)
    @human_player = HumanPlayer.new(name_to_save)
    @enemies = [Player.new("Marine"), Player.new("Bruno"), Player.new("Marius"), Player.new("Romain")]
  end
  ##################################################################
  # Function that kills the player (delete from the enemies array)
  ###################################################################
  def kill_player (player_to_kill)
    @enemies.keep_if { |enemy|  enemy.singleton_class  != player_to_kill.singleton_class } #We erase the player with the same id
    #delete with the object : enemy != player_to_kill
    #delete with the object id : enemy.singleton_class != player_to_kill.singleton_class
    #delete with the name : enemy.name != player_to_kill.name
  end
  ###################################################
  #Function that detect if the game is still ongoing
  ###################################################
  def is_still_ongoing?
    #We suppose that when we kill an enemy, we use the kill_player function so that if there is no enemies to fight we return false
    @enemies.count > 0 ? is_an_enemy_alive = true : is_an_enemy_alive = false
    return @human_player.life_points > 0 &&  is_an_enemy_alive #If there are no enemies left it will return false
  end
  ##################################################
  #Function that shows to the user his information
  ###################################################
  def show_players
    puts "Mon état :"
    puts "#{@human_player.show_state}"
    puts "Nombre de bots restant à tuer : #{@enemies.count}" #We suppose that when we kill an enemy, we use the kill_player function
  end
  ################################################
  #Function that displays the menu for the user
  ################################################
  def menu
    #Options for the player to do
    puts "Quelle action veux-tu effectuer ?\n"
    puts "___________________________________"
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner \n"
    puts "____________________________________"
    puts "Attaquer un joueur en vue :"
    enemies.each_with_index {|enemy, index| puts "#{index} - " + enemy.show_state_v2 if enemy.life_points > 0} #Show all the enemies there
  end
  ##################################################
  #Function : user make a choice
  ###################################################
  def menu_choice
    #Get the user choice (he has to put a correct choice)
    print "choix > "
    choice = gets.chomp
    while (!['a','s'].include?(choice.downcase) && (choice != '0' && choice.to_i >= @enemies.length) )
      print "Pas tout compris. S.V.P. Essayez à nouveau >"
      choice = gets.chomp
    end
    #binding.pry
    case
    when choice.downcase == 'a' #If the user wants to get another weapon
      @human_player.search_weapon
    when choice.downcase == 's' #If the user wants to get healed
      @human_player.search_health_pack
    else
      @human_player.attacks(@enemies[choice.to_i]) #The user attacks the right enemy
      kill_player(@enemies[choice.to_i]) if @enemies[choice.to_i].life_points <= 0 #Kill the bot if no life points left
    end
  end
  ###################################
  #Funtion that make enemies attack #
  ###################################
  def enemies_attack
    #Each that is alive will attack
    puts "-----Les ennemies contre-attaquent !-----"
    @enemies.each { |enemy|
      enemy.attacks(@human_player)
    }
  end
  ########################################
  # Funtion displays the end of the game #
  ########################################
  def end
    if @human_player.life_points > 0
      puts "\n\n------------------- THE END : BRAVO ! TU AS GAGNE !-----------------------"
    else
      puts "\n\n------------------- THE END : Loser ! Tu as perdu !-----------------------"
    end
  end


end
