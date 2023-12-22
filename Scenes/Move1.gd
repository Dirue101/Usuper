extends Sprite2D
var moveName = "None"
@onready var Combat = get_node("/root/Main")
func MatchMove():
	match moveName:
		"":
			$Move1Label.text = ""
		"Nothing":
			$Move1Label.text = ""
		"None":
			$Move1Label.text = ""
		"Punch":
			$Move1Label.text = moveName
			$Move1Button.pressed.connect(Combat.punch)
			
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	MatchMove()
