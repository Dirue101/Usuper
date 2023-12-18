extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = self.PROCESS_MODE_ALWAYS
func OpenClosePauseMenu():
	if $SettingsMenu.is_visible() == true:
			$SettingsMenu.set_visible(false)
			$ResumeButton.set_visible(true)
			$Settings.set_visible(true)
			self.set_visible(true)
			return
			
	if self.is_visible() == true:
			self.set_visible(false)
			get_tree().paused = false
	else:
			self.set_visible(true)
			get_tree().paused = true
			
func _unhandled_input(event):
	if event.is_action_pressed("PauseMenu"):
		OpenClosePauseMenu()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_resume_button_pressed():
	self.set_visible(false)
	get_tree().paused = false


func _on_settings_pressed():
	$ResumeButton.set_visible(false)
	$SettingsMenu.set_visible(true)
	$Settings.set_visible(false)






func _on_infinite_movement_pressed():
	if PlayerStats.infiniteMovement == false:
		PlayerStats.infiniteMovement = true
	else:
		PlayerStats.infiniteMovement = false
	
	
