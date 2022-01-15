extends Popup
onready var returnBtn = get_node("TextureRect/ReturnCreditBtn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ReturnCreditBtn_pressed():
	get_tree().set_quit_on_go_back(true)
	hide()
