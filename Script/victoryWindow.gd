extends Control
onready var textContainer = get_node("PanelContainer/VBoxContainer/ContainerText/VBoxContainer")
var textArray
var newHighscore = false
var wallNode

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func set_value(hpScore, timeScore, extraScore, maxScore, highScore):
		textArray = [hpScore, timeScore, extraScore, maxScore, highScore]
		if(textArray[3] > textArray[4]):
			textArray[4] = textArray[3]
			newHighscore = true
		else:
			newHighscore = false

func setWallNode(setWall):
	wallNode = setWall

func set_text():
	for n in textContainer.get_child_count():
		var pastText = textContainer.get_child(n).get_text()
		if(n >= 4 && newHighscore):
			textContainer.get_child(n).set_text(pastText+String(textArray[n])+" BARU!")
		else:
			textContainer.get_child(n).set_text(pastText+String(textArray[n]))

func _on_Berikutnya_pressed():
	#Cek jika jumlah stage lebih besar dari angka stage berikutnya
	if(Global.stageNumber >= (Global.stage + 1)):
		hide()
		wallNode.closeWall()
		yield(wallNode, "wallDone")
		Global.stage += 1
		get_tree().reload_current_scene()


func _on_Ulang_pressed():
	hide()
	wallNode.closeWall()
	yield(wallNode, "wallDone")
	get_tree().reload_current_scene()


func _on_Menu_pressed():
	hide()
	wallNode.closeWall()
	yield(wallNode, "wallDone")
	get_tree().change_scene("res://Scene/mainMenu.tscn")
