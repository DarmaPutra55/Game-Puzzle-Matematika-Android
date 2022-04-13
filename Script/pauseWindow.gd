extends Control
var wallNode

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func setWallNode(setWall):
	wallNode = setWall

func _on_Kembali_pressed():
	hide()
	get_tree().paused = false


func _on_Ulang_pressed():
	hide()
	wallNode.closeWall()
	yield(wallNode, "wallDone")
	get_tree().reload_current_scene()

func startTimer():
	$ShowTimer.start()

func _on_Menu_pressed():
	hide()
	wallNode.closeWall()
	yield(wallNode, "wallDone")
	get_tree().change_scene("res://Scene/mainMenu.tscn")

func _notification(what):
	if(what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST):
		if(visible && $ShowTimer.time_left == 0):
			get_tree().paused = false
			hide()
