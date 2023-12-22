extends Area2D



const MINIMUM_HEALTH = 25
const MINIMUM_MOVES = 4
const MINIMUM_STAMINA = 20
const MINIMUM_MOVE_SPEED = 4
const MINIMUM_MOVES_PER_TURN = 2 

var meleeable = false

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
#Gameplay Functions
#===================================================================================================================================================================================
func rollInitiative():
	var enemyRoll = ["" + self.name,rollStat("spe")]
	Turn.turnTracker.append(enemyRoll)
func checkTurn():
	if(Turn.currentTurn == self.name):
		startTurn()
func startTurn():
	
	$EnemyCamera.make_current()
	await get_tree().create_timer(5.0).timeout
	EndTurn()
func EndTurn():
	Turn.endTurn()
	
func enemyMutator():
	pass


func updateHealth():
	$HealthBar.max_value = calcFullHealth()
	$HealthBar.value = currentHealth
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_to_group("Combatants")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updateHealth()


func _on_button_pressed():
	if $Targeted.is_visible() == true:
		$Targeted.set_visible(false)
		Global.targeted = "None"
	else:
		$Targeted.set_visible(true)
		Global.targeted = self.name


func _on_melee_range_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print("Melee Range Entered")
	meleeable = true


func _on_melee_range_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	print ("Melee Range Exited")
	meleeable = false
