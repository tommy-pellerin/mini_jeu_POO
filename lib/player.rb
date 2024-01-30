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

class HumanPlayer < Player
attr_accessor :weapon_level

  def initialize(name)
    super(name) #fait appel au initialize de la classe Player
    @weapon_level = 1 #integer
    @life_points = 100 #on a modifier les points de vie pour un Human
    
  end

  def show_state
    puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{weapon_level}"
  end

  def compute_damage
    return rand(1..6) * @weapon_level
  end

  def search_weapon
    dice_result  = rand(1..6) #lancer de dé pour déterminer le niveau de la nouvealle arme
    puts "tu as trouvé une arme de niveau #{dice_result}"#l'arme trouvé est égale au résultat du lancé de dé (entre 1 et 6)
    case
      when dice_result > @weapon_level
        @weapon_level = dice_result
        puts "Youpeee ! elle est meilleur que ton arme actuelle => tu la prends"
      when dice_result == @weapon_level
        puts "Elle est pareil : tu la prends pas"
      when dice_result > @weapon_level
        puts "Elle est moins bien : tu la jette contre..."
    end
  end

  def search_health_pack
    dice_result  = rand(1..6) #lancer de dé
    case
    when dice_result == 1
      puts "Tu n'as rien trouvé"
    when dice_result >= 2 && dice_result <= 5
      @life_points = @life_points + 50 #ajout 50 points de vie sans que la totale dépasse 100
      @life_points = 100 if @life_points > 100 
      puts "Congrat, tu as trouvé un pack de +50 points de vie !"
    when dice_result == 6
      @life_points =  @life_points + 80 #ajout 80 points de vie sans que la totale dépasse 100
      @life_points = 100 if @life_points > 100
      puts "Waow, tu as trouvé un pack de +80 points de vie !"
    end
  end

end