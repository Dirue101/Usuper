extends Area2D
@onready var Player = get_node("../Player")
@export var assignedPower = "None"
@export var assignedMove = "Punch"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	self.set_visible(false)
	Player.MoveList.append(assignedMove)
