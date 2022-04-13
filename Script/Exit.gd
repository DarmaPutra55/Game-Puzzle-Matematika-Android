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

func startTimer():
	$ShowTimer.start()

func _on_BtnYa_pressed():
	get_tree().quit()

func _on_BtnTidak_pressed():
	get_tree().paused = false
	hide()

func _notification(what):
	if(what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST):
		if(visible && $ShowTimer.time_left == 0):
			get_tree().quit()
