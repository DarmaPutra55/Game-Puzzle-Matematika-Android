extends Popup


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BtnYa_pressed():
	get_tree().quit()

func _on_BtnTidak_pressed():
	get_tree().paused = false
	hide()
