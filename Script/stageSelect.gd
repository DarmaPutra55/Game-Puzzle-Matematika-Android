extends Control

onready var selfButton = get_node("Button")

var stageValue
var highscoreValue
var stageSelectMenuNode

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

func setStageText():
	selfButton.set_text("Stage "+String(stageValue))

func setValue(setStage):
	stageValue = setStage

func setHighscoreValue(stageHighscore):
	highscoreValue = stageHighscore[0]["HighScore"]

func _on_Button_button_down():
	stageSelectMenuNode.setStage(stageValue)
	stageSelectMenuNode.setStageText()
	stageSelectMenuNode.setStageHighscoreText(highscoreValue)
	stageSelectMenuNode.show()
