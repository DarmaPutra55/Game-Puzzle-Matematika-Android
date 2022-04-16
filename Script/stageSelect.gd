extends Control

onready var selfButton = get_node("Button")

var stageValue
var highscoreValue
var stageSelectMenuNode
var mainMenu

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func setStageSelectMenuNode(stageSelectMenu):
	stageSelectMenuNode = stageSelectMenu

func setMainMenu(setMain):
	mainMenu = setMain

func setStageText():
	selfButton.set_text("Stage "+String(stageValue))

func setValue(setStage):
	stageValue = setStage

func setHighscoreValue(stageHighscore):
	highscoreValue = stageHighscore[0]["HighScore"]

func _on_Button_button_down():
	$ClickDelay.start()


func _on_Button_button_up():
	if($ClickDelay.time_left > 0):
		mainMenu.modulate = Color("#4d4d4d")
		get_tree().paused = true
		stageSelectMenuNode.setMainMenu(mainMenu)
		stageSelectMenuNode.setStage(stageValue)
		stageSelectMenuNode.setStageText()
		stageSelectMenuNode.setStageHighscoreText(highscoreValue)
		stageSelectMenuNode.show()

