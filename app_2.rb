require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

#initialiser le jeu
puts "-" * 50
puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO'         |"
puts "|Le but du jeu est d'etre le dernier survivant   |"
puts "-" * 50

#initialiser les joueurs
puts "Rentre le nom de ton joueur :"
print "> "
human_player_name = gets.chomp
user = HumanPlayer.new(human_player_name)
player1 = Player.new("José")
player2 = Player.new("Josiane")
enemies = [player1,player2]
i = 0

#debut du jeu
while user.life_points > 0 && (player1.life_points > 0 || player2.life_points > 0)
  #affichage de l'état
  user.show_state

  #démarrage de la partie
  i += 1
  puts "Round #{i} fight !"
  puts "...appui sur ENTRER pour continuer..."
  gets.chomp

  #choix des actions
  puts "Quelle action veux tu faire ?"
  puts "1 - chercher un meilleure arme"
  puts "2 - chercher à te soigner"
  puts "attaquer un joueur en vue :"
  if player1.life_points > 0
    puts "3 --> #{player1.name}"
    player1.show_state
  end
  if player2.life_points > 0
    puts "4 --> #{player2.name}"
    player2.show_state
  end
  print "> "
  user_answer = gets.chomp.to_i
  #execution des actions
  case
    when user_answer == 1
      user.search_weapon
    when user_answer == 2
      user.search_health_pack
    when user_answer == 3
      user.attacks(player1)
      player1.show_state if player1.life_points > 0
    when user_answer == 4
      user.attacks(player2)
      player2.show_state if player2.life_points > 0
  end
  
  puts "...appui sur ENTRER pour continuer..."
  gets.chomp

  #changement d'attaquant
  if (player1.life_points > 0 || player2.life_points > 0)
    puts "Les autres joueurs t'attaquent !"
    enemies.each do |player|
      next if player.life_points < 0 #arret les attaques si un joueur IA est mort
      player.attacks(user)
    end
  end

end

#fin de la partie
if user.life_points > 0
   puts("*** BRAVO, TU AS GAGNE !***")
else 
  puts(">>> GAME OVER <<<")
end
