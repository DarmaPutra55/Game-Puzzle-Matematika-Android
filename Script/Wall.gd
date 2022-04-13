extends Node2D
signal wallDone
var animationProgress

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func openWall():
	if(!visible):
		show()
	var move_tween = get_node("Tween")
	move_tween.interpolate_property(self, "position", position, Vector2(0, -1280), .5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	move_tween.start()	
	
func closeWall():
	if(!visible):
		show()
	var move_tween = get_node("Tween")
	move_tween.interpolate_property(self, "position", position, Vector2(0, 0), .5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	move_tween.start()	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_Tween_tween_all_completed():
	emit_signal("wallDone")
	hide()
