extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var textQuestion = get_parent().get_parent().get_node("Question/QuestionPanel/QuestionText")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func hideAllText():
	for n in get_child_count():
		get_child(n).get_child(0).hide();
	textQuestion.hide()

func showAllText():
	for n in get_child_count():
		get_child(n).get_child(0).show();
	textQuestion.show()

func questionSelection(CurrentWaveQuestion):
	textQuestion.set_text(CurrentWaveQuestion)

func answerAreaSelection(currentWaveAnswer):
	var waveAnswer = [currentWaveAnswer];
	var duplicateNumber = 0;
	for n in 2:
		waveAnswer.append(waveAnswer[0] + int(rand_range(-4, 4))) #Masukan nilai random antara jawaban +/- 8
		while waveAnswer.count(waveAnswer[n+1]) > 1: #Lakukan pengulangan jika ada nilai yang sama dengan nilai yang baru ditambah
			waveAnswer[n+1] = waveAnswer[0] + int(rand_range(-4, 4)) 
	waveAnswer.shuffle()
	for n in get_child_count():
		get_child(n).get_child(0).set_text(String(waveAnswer[n]));
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
