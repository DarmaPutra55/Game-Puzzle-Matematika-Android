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
	self.hide()
	get_tree().paused = false


func _on_Ulang_pressed():
	self.hide()
	wallNode.closeWall()
	yield(wallNode, "wallDone")
	get_tree().reload_current_scene()


func _on_Menu_pressed():
	self.hide()
	wallNode.closeWall()
	yield(wallNode, "wallDone")
	get_tree().change_scene("res://Scene/mainMenu.tscn")
