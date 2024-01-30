class Player
  attr_accessor :name, :life_points

  def initialize(name)
    @name = name #string
    @life_points = 10 #integer
  end

  def show_state
    puts "#{@name} a #{@life_points} points de vie"
  end

  def gets_damage(damage_points)
    @life_points = @life_points - damage_points
    puts "==> le joueur #{name} a été tué ! <==" if @life_points <= 0
      
  end

  def attacks(injured_player)
    puts "#{@name} attaque #{injured_player.name}" 
    damage_inflicted = compute_damage
    
    puts "--> il lui inflige #{damage_inflicted} points de dommages"
    injured_player.gets_damage(damage_inflicted)
  end

  def compute_damage
    return rand(1..6)
  end

end