extends Area2D



# Called when the node enters the scene tree for the first time.
#============================================================================================================================================
func _ready():
	self.add_to_group("Combatants")
	$PlayerCamera.make_current()
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE *tile_size/2

#Player Controls
#============================================================================================================================================
var tile_size = 256
var inputs = {"right": Vector2.RIGHT,
			  "left": Vector2.LEFT,
			"down" : Vector2.DOWN,
			"up" : Vector2.UP}
var movementAllowed = true
func zoomOut():
	if $PlayerCamera.zoom <= Vector2(.4,.4):
			return
	else:
			$PlayerCamera.zoom -= Vector2(.075,.075)
			GlobalPlayer.zoom = $PlayerCamera.zoom
			
func zoomIn():
	if $PlayerCamera.zoom >= Vector2(2,2):
			return
	else:	
			$PlayerCamera.zoom += Vector2(.1,.1)
			GlobalPlayer.zoom = $PlayerCamera.zoom
			
func _unhandled_input(event):
	if event.is_action_pressed("ScrollUp"):
		zoomIn()
	if event.is_action_pressed("ScrollDown"):
		zoomOut()
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			if dir == "left":
				$PlayerSprites.flip_h = true
			elif dir == "right":
				$PlayerSprites.flip_h = false
			move(dir)

func move(dir):
	if movementAllowed == false:
		return
	if GlobalPlayer.infiniteMovement == true:
		updateHUD()
	elif remainingMovement == 0:
		return
		
	else:
		remainingMovement -= 1
		updateHUD()	
	$DetectCollison.target_position = inputs[dir] * tile_size
	$DetectCollison.force_raycast_update()
	if !$DetectCollison.is_colliding():
		position += inputs[dir] * tile_size
	else:
		updateHUD()








#Gameplay Function
#============================================================================================================================================

func resetResources():
	remainingMovement = calcMovementSpeed()
	remainingActions = calcMovesPerRound()

func checkTurn():
	if(Turn.currentTurn == self.name):
		startTurn()
	else:
		$HUD.set_visible(false)
		$HUD.fightUiOff()
		movementAllowed = false
		
func startTurn():
	
	$PlayerCamera.make_current()
	movementAllowed = true
	resetResources()
	$HUD.set_visible(true)
	$HUD.fightUiOn()
	$MovesUI.set_visible(true)
	
func endTurn():
	$HUD.set_visible(false)
	$HUD.fightUiOff()
	movementAllowed = false
	Turn.endTurn()







#Player Stats and Stat Functions
#============================================================================================================================================
const MINIMUM_HEALTH = 25
const MINIMUM_MOVES = 4
const MINIMUM_STAMINA = 20
const MINIMUM_MOVE_SPEED = 4
const MINIMUM_MOVES_PER_TURN = 2 
const strMinBase = 55
const strMaxBase = 80
const MINIMUM_MOVE_SLOTS = 4

@export var strMin = 55
@export var strMax = 80
@export var wilMin = 55
@export var wilMax = 75
@export var intMin = 55
@export var intMax = 90
@export var speMin = 55
@export var speMax = 70
@export var currentHealth = 24
@export var currentStamina = 0
@export var remainingActions = 0
@export var remainingMovement = 4

func rollStat(stat):
	var rollNum = RandomNumberGenerator.new()
	if stat == "Int" || "int" || "Intelligence":
		return rollNum.randi_range(intMin,intMax)
	if stat == "Str" || "str" || "Strength":
		return rollNum.randi_range(strMin,strMax)
	if stat == "Wil" || "wil" || "Will":
		return rollNum.randi_range(wilMin,wilMax)
	if stat == "Spe" || "spe" || "Speed":
		return rollNum.randi_range(speMin,speMax)

func rollInitiative():
	var playerRoll = ["" + self.name,rollStat("spe")]
	Turn.turnTracker.append(playerRoll)
func calcMovesPerRound():
	if (((speMin + speMax)/40)) < MINIMUM_MOVES:
		return MINIMUM_MOVES;
	else:
		return int(round(((speMin + speMax)/40)))

func calcFullHealth():
	if strMax / 4 < MINIMUM_HEALTH:
		return MINIMUM_HEALTH
	else:
		return int(round(strMax/4))

func calcFullStamina():
	if wilMax/3 < MINIMUM_STAMINA:
		return MINIMUM_STAMINA
	else:
		return int(round(wilMax/3))
# Called when the node enters the scene tree for the first time.
func calcMovementSpeed():
	if (speMax/20) <= MINIMUM_MOVE_SPEED:
		return MINIMUM_MOVE_SPEED
	else:
		return speMax/20
func calcActionsPerRound():
	if(((speMax+wilMin)/50) < 2):
		return 2; 
	else:
		return (speMax+wilMin)/50;
func calcMoveSlots():
	if (intMax / 50) < 4:
		return MINIMUM_MOVES_PER_TURN
	else:
		return (intMax/ 50)  

#Powers and Moves
#============================================================================================================================================
var PowerList = []
var MoveList = []
func setMoves():
	if MoveList == []:
		return
	else:
		$MovesUI/MoveList/MoveContainter/Move1.moveName = MoveList[MoveList.size()-1]

#HUD Stuff
#============================================================================================================================================
func updateHUD():
	$HUD/Health.text =  "Health: " + str(currentHealth) + "/" + str(calcFullHealth())
	$HUD/Stamina.text = "Stamina: " + str(currentStamina) + "/" + str(calcFullStamina())
	$HUD/fightUI/Actions.text = "Actions: \n" + str(remainingActions) + "/" + str(calcMovesPerRound())
	$HUD/HealthBar.max_value = calcFullHealth()
	$HUD/HealthBar.value = currentHealth
	$HUD/StaminaBar.max_value = calcFullStamina()
	$HUD/StaminaBar.value = currentStamina
	$HUD/fightUI/AvailableMovement.text = "Remaining Movement:" + str(remainingMovement) + "/" + str(calcMovementSpeed())
	$HUD/ZoomScale.text = "Zoom:" + str(GlobalPlayer.zoom[0])

#Runs every Frame
#============================================================================================================================================
func _process(delta):
	updateHUD()
	setMoves()
	
		



