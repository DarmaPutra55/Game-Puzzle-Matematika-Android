extends Popup
onready var imgBox = get_node("MainImageShow")
var currentTutorial = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_BtnNext_pressed():
	if currentTutorial >= 0 && currentTutorial < 4:
		currentTutorial += 1
		imgBox.get_child(currentTutorial).set_visible(true)


func _on_BtnPrev_pressed():
	if currentTutorial > 0 && currentTutorial <= 4:
		imgBox.get_child(currentTutorial).set_visible(false)
		currentTutorial -= 1

func _on_BtnClose_pressed():
	for n in imgBox.get_child_count() - 1:
		imgBox.get_child(n+1).set_visible(false)
	currentTutorial = 0
	hide()

func _notification(what):
	if(what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST):
		if(visible):
			hide()
