extends Node

@export var strMin = 55
@export var strMax = 80
@export var wilMin = 55
@export var wilMax = 75
@export var intMin = 55
@export var intMax = 90
@export var speMin = 55
@export var speMax = 70
@export var currentHealth = 0
@export var currentStamina = 0
func calcAvailableMoveSlots():
	if (((speMin + speMax)/40)) < 4:
		return 4;
	else:
		return int(round(((speMin + speMax)/40)))
func calcMaxHealth():
	if strMax / 4 < 25:
		return 25
	else:
		return int(round(strMax/4))
func calcMaxStamina():
	if wilMax/3 < 20:
		return 20
	else:
		return int(round(wilMax/3))
# Called when the node enters the scene tree for the first time.
func calcMoveSpeed():
	if (speMax/20) <= 4:
		return 4
	else:
		return speMax/20




func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
