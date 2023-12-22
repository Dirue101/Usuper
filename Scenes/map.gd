extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func showFightIndicator():
	var tween = get_tree().create_tween()
	$FightIndicator.set_visible(true)
	
	tween.tween_property($FightIndicator,"self_modulate",Color.TRANSPARENT,2)
	tween.kill
	
	
func hideFightIndicator():
	pass
	
func fightEntered():
	
	GlobalPlayer.infiniteMovement = false
	showFightIndicator()
	
	get_tree().call_group("Combatants","rollInitiative")
	print(Turn.turnTracker)
	Turn.sortTurnTracker()
	Turn.startTurn()
	
	
func fightEnded():
	var tween = get_tree().create_tween()
	GlobalPlayer.infiniteMovement = true
	$Player/HUD.fightUiOff()
	$FightIndicator.visible = false
	tween.tween_property($HUD/FightIndicator,"self_modulate",Color.BLACK,1)
	Turn.turnTracker = []




func _on_fight_area_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	fightEntered()


func _on_fight_area_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	fightEnded()
