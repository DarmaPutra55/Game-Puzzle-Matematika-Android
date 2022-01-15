extends Control
onready var selfButton = get_node("Button")
var stageValue
var wallNode
signal stageSelected

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func setStageText():
	selfButton.set_text("Stage "+String(stageValue))
	
func setWallNode(setWall):
	wallNode = setWall
	
func setValue(setStage):
	stageValue = setStage
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_Button_button_down():
	Global.stage = stageValue
	wallNode.closeWall()
	yield(wallNode, "wallDone")
	get_tree().change_scene("res://Scene/main.tscn")
