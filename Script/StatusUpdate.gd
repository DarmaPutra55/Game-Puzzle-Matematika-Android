extends VBoxContainer
onready var timeLimitText = get_node("TimeLimit")
onready var playerHPText = get_node("PlayerHp")
onready var currentStageText = get_node("CurrentStage")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	currentStageText.set_text("Stage "+String(Global.stage))

func updateStatusText(time, hp):
	timeLimitText.set_text("Waktu: "+String(time))
	playerHPText.set_text("Nyawa: "+String(hp))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
