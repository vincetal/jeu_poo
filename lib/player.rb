#require 'rubygems'
#-------Pour le scrapping-------
#require 'nokogiri'
#require 'open-uri'
#-------Pour simuler un navigateur-------
#require 'watir'
#require 'launchy'
#-------Pour les tests------
#require 'pry'

#Computer player
class Player

  attr_accessor :name, :life_points

  @@all_players = []

  def initialize (name_to_save) #initialize a player with a name, and 10 life points
    @name = name_to_save
    @life_points = 10
    @@all_players << {:player_id => self, :name => @name, :life_points => @life_points}
  end

  def self.all #get all the users
    return @@all_players
  end

  def show_state #Get the player life points
    puts "#{@name} a #{@life_points} points de vie"
  end

  def show_state_v2 #Get the player life points on the V2 version // returns not put
    return @life_points <=0 ? "#{@name} n'est plus de ce monde..." : "#{@name} a #{@life_points} points de vie"
  end

  def gets_damage (damages_suffered)
    @life_points -= damages_suffered
    puts "le joueur #{@name} a été tué !" if @life_points <= 0
  end

  def attacks(player_attacked)
    attack_done = compute_damage
    puts "#{@name} attaque #{player_attacked.name}\nil lui inflige #{attack_done} points de dommages"
    player_attacked.gets_damage(attack_done)
  end

  def compute_damage
    return rand(1..6).to_i #To be sure that the damage is an integer
  end
=begin
  def self.find_a_player_by_id(player_to_find)
    player_founded = []
    @@all_players.each {|my_player|
      if my_player[:player_id] == player_to_find[:player_id] #if the user is founded
        player_founded << my_player
      end
    }
    return player_founded
  end
=end
end

#Human player
class HumanPlayer < Player

  attr_accessor :weapon_level

  def initialize(name_to_save)
    @weapon_level = 1 #The weapon level is 1 for a starter
    super(name_to_save) #call initialize of class Event
    @life_points = 100 #life_points are 100 for a human
  end

  def show_state
    puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}"
  end

  def compute_damage
    rand(1..6) * @weapon_level
  end

  #Search a weapon and increase user weapon if necessary
  def search_weapon

    roll_dice = rand(1..6) #We roll dice to get a new weapon level
    puts "Tu as trouvé une arme de niveau #{roll_dice}"

    if roll_dice > @weapon_level #If the weapon is better, then take it
      puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
      @weapon_level = roll_dice
    else #Else do nothing
      puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."
    end

  end

  #Search a health pack in order to increase the user life points
  def search_health_pack
    roll_dice = rand(1..6) #We roll the dice ...again ...come on man...

    #We give the user life points depending on the dice number
    case
    when roll_dice == 1
      puts "Tu n'as rien trouvé... "
    when roll_dice.between?(2,5)
      puts "Bravo, tu as trouvé un pack de +50 points de vie !"
      @life_points += 50 #Add 50 life points
      @life_points = 100 if @life_points > 100 #If user has more than 100 life points, then he has 100 points
    else
      "Waow, tu as trouvé un pack de +80 points de vie !"
      @life_points += 80 #Add 80 life points
      @life_points = 100 if @life_points > 100 #If user has more than 100 life points, then he has 100 points
    end
  end

end
