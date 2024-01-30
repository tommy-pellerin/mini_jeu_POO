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
human_player_name = gets.chomp #demande le nom du joueur


my_game = Game.new(human_player_name) #créer un onject Game avec le nom de l'utilisateur qui sera donné à @User

i = 0
#debut du jeu
while my_game.is_still_ongoing?
  #affichage de l'état
  my_game.show_players

  #démarrage de la partie
  i += 1
  puts "==== Round #{i} fight ! ===="
  #tempo
  puts "...appui sur ENTRER pour continuer..."
  gets.chomp

  #affiche menu
  my_game.new_players_in_sight
  my_game.menu
  #choix des actions
  my_game.menu_choice

  #tempo
  puts "...appui sur ENTRER pour continuer..."
  gets.chomp

  #changement d'attaquant
  my_game.enemies_attack
end

#fin de la partie
my_game.end