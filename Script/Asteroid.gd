extends Node2D
var fallspeed = 10

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	position.y += fallspeed
	rotation_degrees += 1
	_outOfAreaDeletion()

func _outOfAreaDeletion():
	if position.y > 1280:
		queue_free()
# Called every frame. '' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_pos(spawnPosition):
	position = spawnPosition

func _on_Area2D_area_entered(area):
	if area.areaType == "Player":
		queue_free()
