extends Node
var targetName = ""
var target
var attacker 


func checkTargSet(target):
	if target == "None" || "" || false:
		return false
	else:
		return true
		
func checkRemainingAction():
	if attacker.remainingActions != 0:
		return true
	return false
func punch():
	
	var punchDamage = (attacker.rollStat("str")/10)
	if checkTargSet(targetName) && target.meleeable && checkRemainingAction() :
		target.currentHealth -= punchDamage
		print(punchDamage)
		attacker.remainingActions -= 1
		if Turn.currentTurn == "Player":
			attacker.updateHUD()
	else:
		return
		
		
		

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	targetName = Global.targeted
	target = get_node("/root/Main/Map/" + Global.targeted)
	attacker = get_node("/root/Main/Map/" + Turn.currentTurn)




func _on_end_turn_pressed():
	pass # Replace with function body.
