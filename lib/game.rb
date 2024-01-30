class Game
  attr_accessor :user, :enemies, :players_left, :enemies_in_sight
  

  def initialize(name)
    @user = HumanPlayer.new(name) #création de l'object user en tant que HumanPlayer
    @enemies = [player1 = Player.new("José"), player2 = Player.new("Josianne"), player3 = Player.new("Jean"), player4 = Player.new("Jaccobe")] #un array de 4 joueur IA
    @player1 = @enemies[0]
    @player2 = @enemies[1]
    @player3 = @enemies[2]
    @player4 = @enemies[3]
    @players_left = 10 #integer
    @enemies_in_sight = @enemies
    
  end

  def kill_player(player)
    @enemies_in_sight.delete(player) #supprime un ennemie du tableau des ennemies
  end
  #version 3.0
  # def is_still_ongoing?
  #   if @user.life_points > 0 && !@enemies.empty? #si la santé du joueur est > 0 et que le tableau des ennemies n'est pas vide
  #     true
  #   end
  # end
  #version4.0
  def is_still_ongoing?
    if @user.life_points > 0 && !@enemies_in_sight.empty? #si la santé du joueur est > 0 et que le tableau des ennemies n'est pas vide
      true
    end
  end

  def new_players_in_sight
    puts "Création d'ennemie encours..."
    if @enemies_in_sight.size == @players_left #si les joueurs sont déjà en vue, on ne créer rien
      puts "Tous les joueurs sont déjà en vue : Pas d'ennemie en plus"
    else
      dice_result = rand(1..6)
      case
        when dice_result == 1
          puts "Tu as de la chance : pas d'ennemie en plus"
        when dice_result >= 2 && dice_result <= 4
          random_name = "player" + rand(100).to_s #générer un nom éléatoire
          @enemies_in_sight << Player.new(random_name) #ajout d'un joueur
          puts "Pas de chance : 1 ennemie en plus"
        when dice_result >= 5
          random_name = "player" + rand(100).to_s #générer un nom éléatoire
          @enemies_in_sight << Player.new(random_name) #ajout d'un joueur
          random_name = "player" + rand(100).to_s #générer un nom éléatoire
          @enemies_in_sight << Player.new(random_name) #ajout d'un joueur
          puts "T'es dans la merde : 2 ennemies en plus"
      end
      @random_player = @enemies_in_sight[4]
    end
    
    
    puts "Il reste #{@enemies_in_sight.size} ennemies à tuer"
    puts ""
  end

  def show_players
    @user.show_state #montre l'état du joueur
    puts "Il reste #{@enemies_in_sight.size} ennemies à tuer" #montre le nombre d'ennemie restant
    puts ""
  end

  def menu
    #choix des actions
    puts "-- Quelle action veux tu faire ? --"
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
    if @random_player.life_points > 0 #cette methode ne fonctionne pas si la valeur est nul
      print "5 --> #{@random_player.name} : "
      @random_player.show_state
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
      when user_answer == 5
        user.attacks(@random_player)
        kill_player(@random_player) if @random_player.life_points < 0 #ce code ne fonctionne pas si la valeur est nul
        @random_player.show_state if @random_player.life_points > 0
      
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