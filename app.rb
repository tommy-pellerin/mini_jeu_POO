require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

#game setting

player1 = Player.new("Josiane")
player2 = Player.new("José")
#setting initialize
puts "Voici l'état de chaque joueur :"
puts player1.show_state
puts player2.show_state

#game fight !
puts "Ready... "
i = 0
while player1.life_points > 0 && player2.life_points > 0

  
  i += 1
  puts "Round #{i} fight !"
  player1.attacks(player2)
  break if player2.life_points <= 0
  player2.attacks(player1)
  break if player1.life_points <= 0

  puts "\nVoici l'état des joueurs :"
  player1.show_state
  player2.show_state
  puts ""
  
end


# binding.pry
puts "== Game Over =="