extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass





func _on_button_pressed():
	if self.is_visible() == true:
		self.set_visible(false)
	else:
		self.set_visible(true)



func _on_moves_button_pressed():
	if $InventoryButton.is_visible() == true:
		$InventoryButton.set_visible(false)
		
	else:
		$InventoryButton.set_visible(true)
		
		
