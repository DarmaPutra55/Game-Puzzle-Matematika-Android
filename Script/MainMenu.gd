extends Control

onready var mainMenu = get_node("ColorRect")
onready var stageNode = get_node("ColorRect/PanelContainer/VBoxContainer/PanelMenu/ScrollContainer")
onready var highscoreNode = get_node("ColorRect/PanelContainer/VBoxContainer/PanelMenu/MenuHighScore")
onready var optionNode = get_node("ColorRect/PanelContainer/VBoxContainer/PanelMenu/OptionMenu")
onready var stageAreaNodeSD = get_node("ColorRect/PanelContainer/VBoxContainer/PanelMenu/ScrollContainer/StageArea/StageAreaSD")
onready var stageAreaNodeSMP = get_node("ColorRect/PanelContainer/VBoxContainer/PanelMenu/ScrollContainer/StageArea/StageAreaSMP")
onready var stageAreaNodeSMA = get_node("ColorRect/PanelContainer/VBoxContainer/PanelMenu/ScrollContainer/StageArea/StageAreaSMA")
onready var highscoreAreaNode = get_node("ColorRect/PanelContainer/VBoxContainer/PanelMenu/MenuHighScore/MarginContainer/VBoxContainer")
onready var credit = get_node("CreditPopup")
onready var wall = get_node("Wall")
onready var tutorial = get_node("TutorialPopup")
onready var stageSelectMenu = get_node("stageSelectPopup")
onready var exitMenu = get_node("ExitPopup")


var highscoreBox_resource = preload("res://Scene/highScoreBox.tscn")
var stageBox_resource = preload("res://Scene/stageButtonGroup.tscn")
var tingkat = {
	0:"SD",
	1:"SMP",
	2:"SMA"
}

var stage = [];
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
		get_tree().paused = false
		_setStageNumber()
		_setHighScore()
		_loadStageBox()
		_loadStageSelect()
		_wallAnimation()
		stageSelectMenu.setWall(wall)
		optionNode.setWallNode(wall)
		optionNode.setTutorialNode(tutorial)
		optionNode.setCreditNode(credit)

func _setStageNumber():
	var temp_stageNumber = Database.retriveDataFromDB(null, 
	"StageNumber")
	for n in 3:
		stage.append_array(Database.retriveDataFromDB(null, 
		"Stage"+tingkat.get(n)))
	Global.stageNumber = temp_stageNumber[0]["JumlahStage"]

func _wallAnimation():
	wall.position = Vector2(0,0)
	wall.openWall()
	get_tree().paused = true
	yield(wall, "wallDone")
	get_tree().paused = false

func _setHighScore():
	var temp_highscoreDictionary = Database.retriveDataFromDB(null, "Highscore")
	for stage in temp_highscoreDictionary.size():
		var highscorebox = highscoreBox_resource.instance()
		highscorebox.setText(stage+1, 
		temp_highscoreDictionary[stage]["HighScore"])
		highscoreAreaNode.add_child(highscorebox)
		

func _loadStageBox():
	var totalBox
	var stageArea
	for kelas in 3:
		match(kelas):
			0:
				stageArea = stageAreaNodeSD
			1:
				stageArea = stageAreaNodeSMP
			2:
				stageArea = stageAreaNodeSMA
		totalBox = ceil(float(stage[kelas][tingkat.get(kelas)])/3);
		for i in totalBox:
			var stageBox = stageBox_resource.instance()
			stageArea.add_child(stageBox)		

func _loadStageSelect():
	var stageNumber = 1
	var stageArea
	for kelas in 3:
		var currentButtonDone = 0 #Untuk menghitung jumlah button yang sudah diberi nilai per kelas
		match(kelas):
			0:
				stageArea = stageAreaNodeSD
			1:
				stageArea = stageAreaNodeSMP
			2:
				stageArea = stageAreaNodeSMA
		for stageRow in stageArea.get_child_count():
			for stageBox in 3:
				var stageButton = stageArea.get_child(stageRow).get_child(0).get_child(0).get_child(0).get_child(stageBox)
				if(currentButtonDone < stage[kelas][tingkat.get(kelas)]): #Selama jumlah button yang diberi nilai dibawah dari jumlah kelas saat ini(Contoh: SD, SMP, SMA) perulangan terus dilakukan
					stageButton.setValue(stageNumber)
					stageButton.setStageSelectMenuNode(stageSelectMenu)
					stageButton.setHighscoreValue(Database.retriveDataFromDB(stageNumber, "Highscore"))
					stageButton.setMainMenu(mainMenu)
					stageButton.setStageText()
					currentButtonDone +=1
					if(!Database.checkStageUnlocked("Stage"+ String(stageNumber))):
						stageButton.get_child(0).disabled = true
					stageNumber += 1
				else:
					stageButton.queue_free() #Untuk menghapus button yg tidak memiliki nilai pada loop

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_StageMenuButton_pressed():
	if(!stageSelectMenu.visible):
		highscoreNode.hide()
		optionNode.hide()
		stageNode.show()

func _on_HighscoreMenuButton_pressed():
	if(!stageSelectMenu.visible):
		stageNode.hide()
		optionNode.hide()
		highscoreNode.show()


func _on_OptionMenuButton_pressed():
	if(!stageSelectMenu.visible):
		stageNode.hide()
		highscoreNode.hide()
		optionNode.show()
		

func _notification(what):
	if(what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST):
		if(!exitMenu.visible && !tutorial.visible && !stageSelectMenu.visible && !credit.visible && !wall.visible):
			get_tree().paused = true
			exitMenu.startTimer()
			exitMenu.show()
