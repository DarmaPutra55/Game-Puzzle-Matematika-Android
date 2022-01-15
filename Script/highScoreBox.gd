extends Control
onready var stageText = get_node("HBoxContainer/PanelContainer/StageText")
onready var scoreText = get_node("HBoxContainer/StageScoreText")
var stage
var highscore
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	stageText.set_text("Stage "+String(stage))
	scoreText.set_text(String(highscore))

func setText(setStage, setHighscore):
	stage = setStage
	highscore = setHighscore
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
