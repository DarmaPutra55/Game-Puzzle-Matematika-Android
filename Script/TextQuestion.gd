extends PanelContainer

onready var textQuestion = get_node("QuestionText")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func hideQuestionText():
	textQuestion.hide()

func showQuestionText():
	textQuestion.show()

func setQuestionText(CurrentWaveQuestion):
	textQuestion.set_text(CurrentWaveQuestion)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
