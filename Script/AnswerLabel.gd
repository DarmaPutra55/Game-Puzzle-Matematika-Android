extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func returnAnswerPosition(location):
	match(location):
		0:
			return 120
		1:
			return 360
		2:
			return 580

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
