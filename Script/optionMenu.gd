extends Control
onready var audioSlider = get_node("MarginContainer/VBoxContainer/MusicBox/MusicSlider")
onready var audioMaster = AudioServer.get_bus_index("Master")
var wallNode
var tutorialNode
var creditNode
var soundDir
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_setSound()
	

func _setSound():
	var file = File.new()
	file.open("user://Database/Sound.json", File.READ)
	soundDir = JSON.parse(file.get_as_text()).result
	file.close()
	audioSlider.value = soundDir["volume"]
	AudioServer.set_bus_volume_db(audioMaster, linear2db(soundDir["volume"]))

func setTutorialNode(setTutorial):
	tutorialNode = setTutorial

func setWallNode(setWall):
	wallNode = setWall

func setCreditNode(setCredit):
	creditNode = setCredit

func _saveVolume():
	var file = File.new()
	file.open("user://Database/Sound.json", File.WRITE)
	soundDir["volume"] = audioSlider.value
	file.store_string(to_json(soundDir))
	file.close()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_MusicSlider_value_changed(value):
	AudioServer.set_bus_volume_db(audioMaster, linear2db(value))
	


func _on_MusicSlider_mouse_exited():
	_saveVolume()
	release_focus()


func _on_RestartButton_pressed():
	if(Database.resetDB()):
		get_tree().set_quit_on_go_back(false)
		wallNode.closeWall()
		yield(wallNode, "wallDone")
		get_tree().reload_current_scene()


func _on_TutorialButton_pressed():
	get_tree().set_quit_on_go_back(false)
	tutorialNode.show()


func _on_CreditButton_pressed():
	get_tree().set_quit_on_go_back(false)
	creditNode.show()
