#===============================================================================
# Flexible Advanced Starter Selection Script for Pokémon Essentials by Limnodromus
# Original version by shiney570.
#===============================================================================
# Editable Pokemon Attributes
#===============================================================================
#  attr_accessor :name        # Nickname
#  attr_reader   :species     # Species (National Pokedex number)
#  attr_reader   :exp         # Current experience points
#  attr_reader   :hp          # Current HP
#  attr_reader   :totalhp     # Current Total HP
#  attr_reader   :attack      # Current Attack stat
#  attr_reader   :defense     # Current Defense stat
#  attr_reader   :speed       # Current Speed stat
#  attr_reader   :spatk       # Current Special Attack stat
#  attr_reader   :spdef       # Current Special Defense stat
#  attr_accessor :status      # Status problem (PBStatuses)
#  attr_accessor :statusCount # Sleep count/Toxic flag
#  attr_accessor :abilityflag # Forces the first/second/hidden (0/1/2) ability
#  attr_accessor :genderflag  # Forces male (0) or female (1)
#  attr_accessor :natureflag  # Forces a particular nature
#  attr_accessor :natureOverride   # Overrides nature's stat-changing effects
#  attr_accessor :shinyflag   # Forces the shininess (true/false)
#  attr_accessor :moves       # Moves (PBMove)
#  attr_accessor :firstmoves  # The moves known when this Pokémon was obtained
#  attr_accessor :item        # Held item
#  attr_accessor :trmoves     # Technical Records
#  attr_writer   :mail        # Mail
#  attr_accessor :fused       # The Pokémon fused into this one
#  attr_accessor :iv          # Array of 6 Individual Values for HP, Atk, Def,
#                             #    Speed, Sp Atk, and Sp Def
#  attr_writer   :ivMaxed     # Array of booleans that max each IV value
#  attr_accessor :ev          # Effort Values
#  attr_accessor :happiness   # Current happiness
#  attr_accessor :ballused    # Ball used
#  attr_accessor :eggsteps    # Steps to hatch egg, 0 if Pokémon is not an egg
#  attr_writer   :markings    # Markings
#  attr_accessor :ribbons     # Array of ribbons
#  attr_accessor :pokerus     # Pokérus strain and infection time
#  attr_accessor :personalID  # Personal ID
#  attr_accessor :trainerID   # 32-bit Trainer ID (the secret ID is in the upper
#                             #    16 bits)
#  attr_accessor :obtainMode  # Manner obtained:
#                             #    0 - met, 1 - as egg, 2 - traded,
#                             #    4 - fateful encounter
#  attr_accessor :obtainMap   # Map where obtained
#  attr_accessor :obtainText  # Replaces the obtain map's name if not nil
#  attr_writer   :obtainLevel # Level obtained
#  attr_accessor :hatchedMap  # Map where an egg was hatched
#  attr_writer   :language    # Language
#  attr_accessor :ot          # Original Trainer's name
#  attr_writer   :otgender    # Original Trainer's gender:
#                             #    0 - male, 1 - female, 2 - mixed, 3 - unknown
#                             #    For information only, not used to verify
#                             #    ownership of the Pokémon
#  attr_writer   :cool,:beauty,:cute,:smart,:tough,:sheen   # Contest stats
#  attr_accessor :criticalHits # Galarian Farfetch'd Evolution Method
#  attr_accessor :yamaskhp    # Yamask Evolution Method
#
# Also will display any pokeball
# BallTypes
#  0  => :POKEBALL,
#  1  => :GREATBALL,
#  2  => :SAFARIBALL,
#  3  => :ULTRABALL,
#  4  => :MASTERBALL,
#  5  => :NETBALL,
#  6  => :DIVEBALL,
#  7  => :NESTBALL,
#  8  => :REPEATBALL,
#  9  => :TIMERBALL,
#  10 => :LUXURYBALL,
#  11 => :PREMIERBALL,
#  12 => :DUSKBALL,
#  13 => :HEALBALL,
#  14 => :QUICKBALL,
#  15 => :CHERISHBALL,
#  16 => :FASTBALL,
#  17 => :LEVELBALL,
#  18 => :LUREBALL,
#  19 => :HEAVYBALL,
#  20 => :LOVEBALL,
#  21 => :FRIENDBALL,
#  22 => :MOONBALL,
#  23 => :SPORTBALL,
#  24 => :DREAMBALL,
#  25 => :BEASTBALL
#
#===============================================================================
def pbSetStarters

	starterLevel = 5 # Feel free to change the value for the Level of your Starters.

  #Pokemon Array
  #=======
	#Here is the array of pokemon species ###s from which we will create our actual Pokemon
	#If you aren't editing Forms/Attributes for any Pokemon all you need to set is this array
	pkmn_array = [152,155,158]

	#Iterate through the previous array and create a pokemon for each species.
	@data={}
	for i in 0...pkmn_array.length
  	@data["pkmn_#{i}"] = PokeBattle_Pokemon.new(pkmn_array[i], starterLevel)
  end
  #=======

  #Scene Creation
  #=======
	# Create the Scene objects
	selection = PokemonSelection.new(@data)

	# If you would like to store the players selection with index base 1
	###Default: 7 (Starter Choice)###
	selection.gameVariable = 7

	# Set the scene background
	###Default: "Graphics/Pictures/Selection Screen/bg")###
	selection.bgPath = "Graphics/Pictures/Selection Screen/bg"

	# Set the X and Y location of the TOP LEFT ball, based on a center origin of the ball sprite (all other ball are calculated dynamically from here)
 	###Default: 140,100###
	selection.firstBallX = 140
	selection.firstBallY = 100

	# Set the X and Y location of the selected Pokemon's sprite, based on a center origin of the Battler sprite (all stats displayed are calculated dynamically from here)
 	###Default: 220,175###
	selection.speciesSpriteX = 220
	selection.speciesSpriteY = 175

	# Select how many balls are in each row
 	###Default: 5###
	selection.ballRowSize = 5

	#If you want your "select" sprite to appear over the ball set to true (like Shoney570's original script)
 	###Default: false###
	selection.selectSpriteOverBall = false

	#Run the method that actually opens the scene
	selection.openscene
  #=======

end

#===============================================================================
# PokemonSelection Class
#===============================================================================
# If attributes are set correctly, no editing should be needed below here
#===============================================================================
class PokemonSelection

  attr_accessor :gameVariable
  attr_accessor :bgPath
  attr_accessor :firstBallX
  attr_accessor :firstBallY
  attr_accessor :speciesSpriteX
  attr_accessor :speciesSpriteY
  attr_accessor :ballRowSize
  attr_accessor :selectSpriteOverBall

# Returns the firstBallX value
  def gameVariable
    return @gameVariable
  end

  # Sets the firstBallX value
  def gameVariable=(value)
    @gameVariable = value.to_i
  end

  # Returns the firstBallX value
  def bgPath
    return @bgPath
  end

  # Sets the firstBallX value
  def bgPath=(value)
    @bgPath = value.to_s
  end

  # Returns the firstBallX value
  def firstBallX
    return @firstBallX
  end

  # Sets the firstBallX value
  def firstBallX=(value)
    @firstBallX = value.to_i
  end

# Returns the firstBallX value
  def firstBallY
    return @firstBallY
  end

  # Sets the firstBallX value
  def firstBallY=(value)
    @firstBallY = value.to_i
  end

  # Returns the firstBallX value
  def speciesSpriteX
    return @speciesSpriteX
  end

  # Sets the firstBallX value
  def speciesSpriteX=(value)
    @speciesSpriteX = value.to_i
  end

  # Returns the firstBallX value
  def speciesSpriteY
    return @speciesSpriteY
  end

  # Sets the firstBallX value
  def speciesSpriteY=(value)
    @speciesSpriteY = value.to_i
  end

  # Returns the firstBallX value
  def ballRowSize
    return @ballRowSize
  end

  # Sets the firstBallX value
  def ballRowSize=(value)
    @ballRowSize = value.to_i
  end

  # Returns the firstBallX value
  def selectSpriteOverBall
    return @selectSpriteOverBall
  end

  # Sets the firstBallX value
  def selectSpriteOverBall=(value)
    if value == true
    	@selectSpriteOverBall = true
    else
    	@selectSpriteOverBall = false
    end
  end

 def initialize(pkmn_array,gameVariable=nil,bgPath=nil,firstBallX=nil,firstBallY=nil,speciesSpriteX=nil,speciesSpriteY=nil,ballRowSize=nil,selectSpriteOverBall=nil)
  @data=pkmn_array

  @select=0
  @doneSelecting = false

  @firstBallX 			= firstBallX
  @firstBallY 			= firstBallY
  @speciesSpriteX 		= speciesSpriteX
  @speciesSpriteY 		= speciesSpriteX
  @ballRowSize 			= ballRowSize
  @selectSpriteOverBall = selectSpriteOverBall
  @gameVariable 		= gameVariable
  @bgPath 				= bgPath

  @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
  @viewport.z=99999

  @pokemon=@data["pkmn_#{@select}"]

  @sprites={}
 end

 def openscene
  @sprites["bg"]=IconSprite.new(0,0,@viewport)
  @sprites["bg"].setBitmap(@bgPath )
  @sprites["bg"].opacity=0

  @sprites["select"]=IconSprite.new(0,0,@viewport)
  @sprites["select"].setBitmap("Graphics/Pictures/Selection Screen/select")
  @sprites["select"].opacity=0
  @sprites["select"].x=5000
  @sprites["select"].ox = @sprites["select"].bitmap.width/2
  @sprites["select"].oy = @sprites["select"].bitmap.height if @selectSpriteOverBall

  for i in 0...@data.length
	@sprites["ball_#{i}"]=IconSprite.new(0,0,@viewport)
	ballstr = @data["pkmn_#{i}"].ballused
  	ballstr = "0" + @data["pkmn_#{i}"].ballused.to_s if @data["pkmn_#{i}"].ballused < 10
  	ballmap = Bitmap.new("Graphics/Battle animations/ball_#{ballstr}")
    rect=Rect.new(0,16,32,48)
    @sprites["ball_#{i}"].bitmap = Bitmap.new(32,32)
    @sprites["ball_#{i}"].bitmap.blt(0,0,ballmap,rect)
    @sprites["ball_#{i}"].x= @firstBallX + (@sprites["ball_#{i}"].bitmap.width  * 1.2) * (i% @ballRowSize)
    @sprites["ball_#{i}"].y= @firstBallY + (@sprites["ball_#{i}"].bitmap.height * 1.5) * (i/ @ballRowSize).floor + (@sprites["ball_#{i}"].bitmap.height/3) * ((i% @ballRowSize)%2)
    @sprites["ball_#{i}"].ox = @sprites["ball_#{i}"].bitmap.width/2
	@sprites["ball_#{i}"].oy = @sprites["ball_#{i}"].bitmap.height/2
    @sprites["ball_#{i}"].opacity=0

	@sprites["pkmn_#{i}"]=PokemonSprite.new(@viewport)
	species = @data["pkmn_#{i}"].species
	gender = @data["pkmn_#{i}"].gender
	form = @data["pkmn_#{i}"].form
	shiny = @data["pkmn_#{i}"].shiny?
	@sprites["pkmn_#{i}"].setSpeciesBitmap(species,(gender==1),form,shiny)
	@sprites["pkmn_#{i}"].x=@speciesSpriteX
	@sprites["pkmn_#{i}"].y=@speciesSpriteY
	@sprites["pkmn_#{i}"].z=5000
	@sprites["pkmn_#{i}"].opacity=0
	@sprites["pkmn_#{i}"].ox = @sprites["pkmn_#{i}"].bitmap.width/2
	@sprites["pkmn_#{i}"].oy = @sprites["pkmn_#{i}"].bitmap.height/2
	@sprites["pkmn_#{i}"].zoom_x=1.5
	@sprites["pkmn_#{i}"].zoom_y=1.5
  end

  @sprites["overlay"]=BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
  @sprites["overlay"].opacity=0

  25.times do
    @sprites["bg"].opacity+=10.2
	for i in 0...@data.length
		@sprites["ball_#{i}"].opacity+=10.2
	end
	@sprites["select"].opacity+=10.2
    pbWait(1)
  end
  self.gettinginput
  self.input_action
 end

 def closescene
  25.times do
    @sprites["bg"].opacity-=10.2
    for i in 0...@data.length
		@sprites["ball_#{i}"].opacity-=10.2
		@sprites["pkmn_#{i}"].opacity-=10.2
	end
    @sprites["select"].opacity-=10.2
    @sprite.opacity-=10.2
    @sprites["pkmn_#{@select}"].opacity-=10.2
    @sprites["overlay"].opacity-=10.2
    pbWait(1)
    end
  end

 def gettinginput
  if Input.trigger?(Input::RIGHT)  && @select < @data.length - 1
    @select+=1
  end
  if Input.trigger?(Input::LEFT) && @select > 0
    @select-=1
  end
  if Input.trigger?(Input::UP)  && @select >= @ballRowSize
    @select-=@ballRowSize
  end
  if Input.trigger?(Input::DOWN) && @select < @data.length - @ballRowSize
    @select+=@ballRowSize
  end
  if defined?($mouse)
    for i in 0...@data.length
      if $mouse.over?(@sprites["ball_#{i}"]) && !$mouse.isStatic?
        @select=i
      end
    end
    if $mouse.leftClick?(@sprites["ball_#{@select}"])
      pressBall
    end
  end
  if Input.trigger?(Input::C)
    pressBall
  end
 end

 def pressBall
  @sprites["select"].visible=false
  @sprites["pkmn_#{@select}"].visible=true
  ballstr = @data["pkmn_#{@select}"].ballused
  ballstr = "0" + @data["pkmn_#{@select}"].ballused.to_s if @data["pkmn_#{@select}"].ballused < 10
  20.times do
    @sprites["pkmn_#{@select}"].opacity+=255/20
    @sprite.opacity+=255/20; @sprites["overlay"].opacity+=255/20
    @sprites["ball_#{@select}"].bitmap = Bitmap.new("Graphics/Battle animations/ball_#{ballstr}_open")
    @sprites["ball_#{@select}"].y-=2
    @sprites["ball_#{@select}"].zoom_x+=0.02
    @sprites["ball_#{@select}"].zoom_y+=0.02
    for j in 0...@data.length
      @sprites["ball_#{j}"].opacity-=10 if !(j==@select)
  	end
	pbWait(1)
  end
  @sprite.visible=true
	pbPlayCrySpecies(@data[@select-1])
  pbWait(20)
  if pbConfirmMessage("Do you want #{@pokemon.name}?")
    @pokemon.ot        = $Trainer.name
    @pokemon.trainerID = $Trainer.id
    pbAddPokemon(@pokemon,@pokemon.level)

    if @gameVariable != nil
    	$game_variables[@gameVariable]=@select+1
    end
    @doneSelecting = true
    self.closescene
  else
	ballmap = Bitmap.new("Graphics/Battle animations/ball_#{ballstr}")
	rect=Rect.new(0,16,32,48)
	@sprites["ball_#{@select}"].bitmap = Bitmap.new(32,32)
	@sprites["ball_#{@select}"].bitmap.blt(0,0,ballmap,rect)
    20.times do
      @sprites["pkmn_#{@select}"].opacity-=255/20
      @sprite.opacity-=255/20; @sprites["overlay"].opacity-=255/20
      @sprites["ball_#{@select}"].y+=2
      @sprites["ball_#{@select}"].zoom_x-=0.02; @sprites["ball_#{@select}"].zoom_y-=0.02
      for j in 0... @data.length
        @sprites["ball_#{j}"].opacity+=10 if !(j==@select)
      end
      pbWait(1)
    end
      @sprites["pkmn_#{@select}"].visible=false
      @sprite.visible=false
      @sprites["select"].visible=true
    end
  end

 def input_action
  while @doneSelecting == false
    Graphics.update
    Input.update
    @pokemon=@data["pkmn_#{@select}"]
    self.gettinginput

    for i in 0... @data.length
   	  @sprites["ball_#{i}"].y= @firstBallY + (@sprites["ball_#{i}"].bitmap.height * 1.5) * (i/@ballRowSize).floor + (@sprites["ball_#{i}"].bitmap.height/3)  * ((i% @ballRowSize)%2)
      @sprites["ball_#{i}"].y -=10 if i==@select
    end

    @sprites["select"].x= @sprites["ball_#{@select}"].x
    @sprites["select"].y= @sprites["ball_#{@select}"].y
    self.text; self.typebitmap
  end
 end

 def text
  overlay= @sprites["overlay"].bitmap
  overlay.clear
  baseColor=Color.new(255, 255, 255)
  shadowColor=Color.new(0,0,0)
  pbSetSystemFont(@sprites["overlay"].bitmap)
  if(@pokemon.form > 0)
    name = @pokemon.fName + " " + @pokemon.name
  else
    name = @pokemon.name
  end

  textpos=[]
  textpos.push([_INTL("{1}", name),@speciesSpriteX + (@sprites["pkmn_#{@select}"].bitmap.width/2) + 20,@speciesSpriteY,false,baseColor,shadowColor])
  # Draw gender symbol
  if @pokemon.male?
    textpos.push([_INTL("♂"),@speciesSpriteX + (@sprites["pkmn_#{@select}"].bitmap.width/2),@speciesSpriteY,0,Color.new(0,112,248),Color.new(120,184,232)])
  elsif @pokemon.female?
    textpos.push([_INTL("♀"),@speciesSpriteX + (@sprites["pkmn_#{@select}"].bitmap.width/2),@speciesSpriteY,0,Color.new(232,32,16),Color.new(248,168,184)])
  end
  pbDrawTextPositions(overlay,textpos)
 end

 def typebitmap
  @sprite=Sprite.new(@viewport)
  @sprite.bitmap=Bitmap.new(194,28)

  @sprite.opacity=0
  @bitmap=BitmapCache.load_bitmap("Graphics/Pictures/types")

  @type1rect=Rect.new(0,@pokemon.type1*28,64,28)
  @type2rect=Rect.new(0,@pokemon.type2*28,64,28)

  if @pokemon.type1==@pokemon.type2
    @sprite.x=@speciesSpriteX + (@sprites["pkmn_#{@select}"].bitmap.width/2)
    @sprite.y=@speciesSpriteY + 30;
    @sprite.bitmap.blt(0,0,@bitmap,@type1rect)
  else
    @sprite.x=@speciesSpriteX + (@sprites["pkmn_#{@select}"].bitmap.width/2)
    @sprite.y=@speciesSpriteY + 30;
    @sprite.bitmap.blt(0,0,@bitmap,@type1rect)
    @sprite.bitmap.blt(66,0,@bitmap,@type2rect)
  end
 end
end
