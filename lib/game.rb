class Game
  attr_accessor :user, :enemies
  

  def initialize(name)
    @user = HumanPlayer.new(name) #création de l'object user en tant que HumanPlayer
    @enemies = [player1 = Player.new("José"), player2 = Player.new("Josianne"), player3 = Player.new("Jean"), player4 = Player.new("Jaccobe")] #un array de 4 joueur IA
    @player1 = @enemies[0]
    @player2 = @enemies[1]
    @player3 = @enemies[2]
    @player4 = @enemies[3]
  end

  def kill_player(player)
    @enemies.delete(player) #supprime un ennemie du tableau des ennemies
  end

  def is_still_ongoing?
    if @user.life_points > 0 && !@enemies.empty? #si la santé du joueur est > 0 et que le tableau des ennemies n'est pas vide
      true
    end
  end

  def show_players
    @user.show_state #montre l'état du joueur
    puts "Il reste #{@enemies.size} ennemies à tuer" #montre le nombre d'ennemie restant
    puts ""
  end

  def menu
    #choix des actions
    puts "Quelle action veux tu faire ?"
    puts "99 - chercher une meilleure arme"
    puts "98 - chercher à te soigner"
    puts "attaquer un joueur en vue :"
    if @player1.life_points > 0
      print "1 --> #{@player1.name} : "
      @player1.show_state
    end
    if @player2.life_points > 0
      print "2 --> #{@player2.name} : "
      @player2.show_state
    end
    if @player3.life_points > 0
      print "3 --> #{@player3.name} : "
      @player3.show_state
    end
    if @player4.life_points > 0
      print "4 --> #{@player4.name} : "
      @player4.show_state
    end
    print "> "
    
  end

  def menu_choice
  #demande une réponse
    user_answer = gets.chomp.to_i
  #execution des actions
    case
      when user_answer == 99
        user.search_weapon
      when user_answer == 98
        user.search_health_pack
      when user_answer == 1
        user.attacks(@player1)
        kill_player(@player1) if @player1.life_points < 0
        @player1.show_state if @player1.life_points > 0
      when user_answer == 2
        user.attacks(@player2)
        kill_player(@player2) if @player2.life_points < 0
        @player2.show_state if @player2.life_points > 0
      when user_answer == 3
        user.attacks(@player3)
        kill_player(@player3) if @player3.life_points < 0
        @player3.show_state if @player3.life_points > 0
      when user_answer == 4
        user.attacks(@player4)
        kill_player(@player4) if @player4.life_points < 0
        @player4.show_state if @player4.life_points > 0
      end
  end

  def enemies_attack
    #changement d'attaquant
    if !@enemies.empty?
      puts "Les autres joueurs t'attaquent !"
      @enemies.each do |player|
        next if player.life_points < 0 #arret les attaques si un joueur IA est mort
        player.attacks(user)
      end
    end
  end

  def end
    #fin de la partie
    if user.life_points > 0
      puts("*** ^^ BRAVO, TU AS GAGNE ! ^^ ***")
    else 
    puts(">>> GAME OVER <<<")
    end
  end
  


end #fin de la classe