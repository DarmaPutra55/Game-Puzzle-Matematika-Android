extends Control
onready var player = get_node("MainControl/Player")
onready var answerText = get_node("MainControl/FullPanel/Button/ButtonContainer/LowerButton")
onready var questionText = get_node("MainControl/FullPanel/Question/QuestionPanel")
onready var spawnArea = get_node("MainControl/FullPanel/EnemySpawnPoint/SpawnContainer")
onready var status = get_node("MainControl/FullPanel/Button/ButtonContainer/UpperButton/StatusContainer")
onready var pause = get_node("PauseWindow")
onready var victory = get_node("VictoryWindow")
onready var gameover = get_node("GameoverWindow")
onready var gameoverSFX = get_node("GameOverSound")
onready var gamearea = get_node("MainControl")
onready var questionTimer = get_node("MainControl/FullPanel/Button/ButtonContainer/UpperButton/QuestTimer")
onready var wall = get_node("Wall")
var asteroid_resource = preload("res://Scene/asteroid.tscn")
var levelWave = 0
var playerHP = Global.playerHP
var stageData
var clearTime = 0
var extraScore = 0
var maxScore = 0
var hpScore = 0
var timeScore = 0
var highScore = 0

# Untuk lokasi spawn, sebaiknya dipindah nanti

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	get_tree().set_quit_on_go_back(false)
	randomize()
	_randomizeStageData()
	_setWallForChild()
	questionText.hideQuestionText()
	answerText.hideAnswerText()
	_getHighscore()
	wall.openWall()
	_newGame()

func _getHighscore():
	var tempScore = Database.retriveDataFromDB(Global.stage, "Highscore")
	highScore = tempScore[0]["HighScore"]

func _randomizeStageData():
	stageData = Database.retriveDataFromDB("Stage"+String(Global.stage), "Stage")
	stageData.shuffle()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	if(levelWave < 5):
		var currentTime = String(int(round($Timer/QuestionTimer.get_time_left())))
		questionTimer.set_text(currentTime)
		status.updateStatusText(clearTime, playerHP)
		

func _newGame():
	player.start($MainControl/Player/StartPosition.position)
	yield(wall, "wallDone")
	$Timer/CooldownTimer.start()
	

func _spawnEnemy(currentWaveAnswer):
	for n in spawnArea.get_child_count():
		var currentText = answerText.get_child(0).get_child(n).get_child(0).get_text()
		if currentText != String(currentWaveAnswer):
			var asteroid = asteroid_resource.instance()
			asteroid.set_pos(spawnArea.get_child(n).position)
			gamearea.add_child(asteroid)


func _on_LeftButton_pressed():
	player.move(Global.left_pos, .5)


func _on_MiddleButton_pressed():
	player.move(Global.center_pos, .5)


func _on_RightButton_pressed():
	player.move(Global.right_pos, .5)


func _on_CooldownTimer_timeout():
	$Timer/ClearTimer.start()
	$Timer/QuestionTimer.start()
	questionText.setQuestionText(stageData[levelWave]["Question"])
	answerText.setAnswerText(stageData[levelWave]["Answer"])
	questionText.showQuestionText()
	answerText.showAnswerText()


func _on_QuestionTimer_timeout():
	if levelWave < 5:
		clearTime += 1
		_answerSelected()

func _checkPlayerAnswer(currentWaveAnswer):
	for n in answerText.get_child(0).get_child_count():
		var currentAnswerText = answerText.get_child(0).get_child(n).get_child(0)
		if currentAnswerText.get_text() == String(currentWaveAnswer):
			var answerTextPos = currentAnswerText.returnAnswerPosition(n)
			player.answerPositionCheck(answerTextPos)

func _changeTextColor(currentWaveAnswer):
	for n in answerText.get_child(0).get_child_count():
		var currentAnswerText = answerText.get_child(0).get_child(n).get_child(0)
		if(currentWaveAnswer != null):
			if currentAnswerText.get_text() == String(currentWaveAnswer):
				currentAnswerText.add_color_override("font_color", 
				Color(1, 0.84, 0, 1))
		else:
			currentAnswerText.add_color_override("font_color", 
			Color( 1, 1, 1, 1 ))

func _on_ClearTimer_timeout():
	clearTime += 1

func _victory():
	$Timer/ClearTimer.stop()
	questionText.hideQuestionText()
	answerText.hideAnswerText()
	$MainControl/FullPanel.visible = false
	player.move(Vector2(player.position.x, -180), 1)
	$Timer/VictoryTimer.start()
	
func _scoring():
	hpScore = playerHP * 1000
	if(clearTime > 10):
		timeScore = 5000 - (clearTime * 250)
		if(timeScore < 0):
			timeScore = 0
	else:
		timeScore = 5000
	if(playerHP == Global.playerHP):
		extraScore = 5000
	maxScore = hpScore + timeScore + extraScore
	if(!Database.checkStageUnlocked("Stage"+String(Global.stage + 1))):
		Database.unlockNewStage(Global.stage + 1)
	if(maxScore > highScore):
		Database.insertDataToDB("Stage"+String(Global.stage), 
		maxScore)
		
func _gameOver():
	$MainControl.visible = false
	player.hide()
	get_tree().paused = true
	gameover.show()
	gameoverSFX.play()

func _on_Player_hit():
	playerHP -= 1
	if playerHP == 0:
		_gameOver()

func _answerSelected():
	player.movementLock = true
	if(player.showMovementState() == true):
		yield(player, "movementDone")
	_spawnEnemy(stageData[levelWave]["Answer"])
	_changeTextColor(stageData[levelWave]["Answer"])
	_checkPlayerAnswer(stageData[levelWave]["Answer"])
	$Timer/ClearTimer.stop()
	$Timer/AnswerTimer.start()

func _pause():
	pause.show()
	get_tree().paused = true

func _on_AnswerTimer_timeout():
	player.movementLock = false
	questionText.hideQuestionText()
	answerText.hideAnswerText()
	levelWave += 1
	_changeTextColor(null)
	if(levelWave < 5):
		$Timer/CooldownTimer.start()
	else:
		_scoring()
		_victory()


func _on_UpperButton_pressed():
	if($Timer/QuestionTimer.time_left > 0):
		$Timer/QuestionTimer.stop()
		_answerSelected()

func _setWallForChild():
	pause.setWallNode(wall)
	victory.setWallNode(wall)
	gameover.setWallNode(wall)

func _on_VictoryTimer_timeout():
	victory.set_value(hpScore, timeScore, extraScore, 
	maxScore, highScore)
	victory.set_text()
	get_tree().paused = true
	victory.show()

func _on_Button_pressed():
	if(!pause.visible):
		_pause()
	
func _notification(what):
	if(what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST):
		if(levelWave < 5 && !pause.visible && !gameover.visible && !victory.visible):
			_pause()
