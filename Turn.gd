extends Node
var turnNumber = 0
var currentTurn = ""
func turn_sort(a,b):
	if a[1] > b[1]:
		return true	
	return false

#turnTracker will contain a dictionary. This dictionary will be ordered in the form of EntityID (e.g. "Player",) 
#as the key and the value will equal the Speed rolls for the appropriate entities
var turnTracker = []
func sortTurnTracker():
	turnTracker.sort_custom(turn_sort)
	print(turnTracker)

func startTurn():
	
	if turnNumber > turnTracker.size() - 1:
		turnNumber = 0
	currentTurn = turnTracker[turnNumber][0]
	get_tree().call_group("Combatants","checkTurn")
func endTurn():
	turnNumber += 1
	startTurn()













# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
