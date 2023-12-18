extends Node
const MINIMUM_HEALTH = 25
const MINIMUM_MOVES = 4
const MINIMUM_STAMINA = 20
const MINIMUM_MOVE_SPEED = 4
const MINIMUM_MOVES_PER_TURN = 2 



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



func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
