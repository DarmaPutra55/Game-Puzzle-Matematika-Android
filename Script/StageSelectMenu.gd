extends Popup

onready var stageSelectText = get_node("VBoxContainer/StageSelectHeaderContainer/StageSelectText")
onready var stageHighscoreText = get_node("VBoxContainer/StageSelectHighscoreText/MarginContainer/HighScoreText")

var wallNode
var stageValue
var mainMenu


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setMainMenu(setMain):
	mainMenu = setMain

func setWall(Wall):
	wallNode = Wall

func setStage(Stage):
	stageValue = Stage

func setStageText():
	stageSelectText.set_text("Stage "+String(stageValue))

func setStageHighscoreText(Highscore):
	stageHighscoreText.set_text("Highscore: "+String(Highscore))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BtnKembali_pressed():
	mainMenu.modulate = Color("#ffffff")
	get_tree().paused = false
	hide()


func _on_BtnMain_pressed():
	hide()
	Global.stage = stageValue
	wallNode.closeWall()
	yield(wallNode, "wallDone")
	get_tree().change_scene("res://Scene/main.tscn")

func _notification(what):
	if(what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST):
		if(visible):
			mainMenu.modulate = Color("#ffffff")
			get_tree().paused = false
			hide()
