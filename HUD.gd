extends CanvasLayer



func updateHUD():
	$Health.text =  "Health: " + str(PlayerStats.currentHealth) + "/" + str(PlayerStats.calcFullHealth())
	$Stamina.text = "Stamina: " + str(PlayerStats.currentStamina) + "/" + str(PlayerStats.calcFullStamina())
	$Actions.text = "Actions: \n" + str(PlayerStats.remainingActions) + "/" + str(PlayerStats.calcMovesPerRound())
	$HealthBar.max_value = PlayerStats.calcFullHealth()
	$HealthBar.value = PlayerStats.currentHealth
	$StaminaBar.max_value = PlayerStats.calcFullStamina()
	$StaminaBar.value = PlayerStats.currentStamina
	$AvailableMovement.text = "Remaining Movement:" + str(PlayerStats.remainingMovement) + "/" + str(PlayerStats.calcMovementSpeed())
	$ZoomScale.text = "Zoom:" + str(GlobalPlayer.zoom[0])
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updateHUD()





func _on_damage_button_pressed():
	PlayerStats.currentHealth -= 1 
	


func _on_full_heal_pressed():
	PlayerStats.currentHealth = PlayerStats.calcFullHealth() # Replace with function body.


func _on_refill_movement_pressed():
	PlayerStats.remainingMovement = PlayerStats.calcMovementSpeed()
