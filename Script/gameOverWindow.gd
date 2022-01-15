extends Control
var wallNode

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setWallNode(setWall):
	wallNode = setWall

func _on_RestartButton_pressed():
	self.hide()
	wallNode.closeWall()
	yield(wallNode, "wallDone")
	get_tree().reload_current_scene()

func _on_MainButton_pressed():
	self.hide()
	wallNode.closeWall()
	yield(wallNode, "wallDone")
	get_tree().change_scene("res://Scene/mainMenu.tscn")
