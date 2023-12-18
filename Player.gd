extends Area2D
var tile_size = 256
var inputs = {"right": Vector2.RIGHT,
			  "left": Vector2.LEFT,
			"down" : Vector2.DOWN,
			"up" : Vector2.UP}

# Called when the node enters the scene tree for the first time.
func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE *tile_size/2


func zoomOut():
	if $Camera2D.zoom <= Vector2(.4,.4):
			return
	else:
			$Camera2D.zoom -= Vector2(.075,.075)
			GlobalPlayer.zoom = $Camera2D.zoom
func zoomIn():
	if $Camera2D.zoom >= Vector2(2,2):
			return
	else:	
			$Camera2D.zoom += Vector2(.1,.1)
			GlobalPlayer.zoom = $Camera2D.zoom
			














	
func fightEntered():
	GlobalPlayer.infiniteMovement = false
	$HUD.AvailableMovement.set_visible(true) 
	$HUD.Actions.set_visible(true)
	$HUD.FightIndicator.set_visible(true)
	$HUD.FightIndicator.text = "Fight!"
	PlayerStats.remainingMovement = PlayerStats.calcMovementSpeed()
	PlayerStats.remainingActions = PlayerStats.calcMovesPerRound()
func fightEnded():
	GlobalPlayer.infiniteMovement = true
	$HUD.AvailableMovement.set_visible(false) 
	$HUD.Actions.set_visible(false)
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
	if GlobalPlayer.infiniteMovement == true:
		$HUD.updateHUD()
	elif GlobalPlayer.remainingMovement == 0:
		return
	else:
		GlobalPlayer.remainingMovement -= 1
		$HUD.updateHUD()	
	$DetectCollison.target_position = inputs[dir] * tile_size
	$DetectCollison.force_raycast_update()
	if !$DetectCollison.is_colliding():
		position += inputs[dir] * tile_size
	else:
		$HUD.updateHUD()
# Called every frame. 'delta' is the elapsed time since the previous frame.


func _process(delta):
	pass


func _on_moves_button_pressed():
	pass # Replace with function body.

func _on_fight_zone_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print("area entered!")


func _on_fight_zone_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	pass # Replace with function body.
