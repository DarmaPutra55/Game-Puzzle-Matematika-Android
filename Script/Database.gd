extends Node2D

const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var db
var dbPath = "user://Database/DBMathGame.db"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func retriveDataFromDB(stage, dataType):
	var query = null
	var queryResult = null
	db = SQLite.new()
	db.path = dbPath
	db.open_db()
	query = _dbRequestChecker(stage, dataType)
	db.query(query)
	queryResult = db.query_result
	db.close_db()
	return queryResult
	
	

func _dbRequestChecker(stage, dataType):
	match(dataType):
		"UnlockedStage":
			return "SELECT count(*) as Unlocked FROM TableStage WHERE  StageName = '"+stage+"' AND Unlocked = 'Y' Group By Unlocked"
		"Stage":
			return "SELECT TableQuestion.Question, TableQuestion.Answer FROM TableStage INNER JOIN TableQuestion WHERE TableStage.StageId = TableQuestion.StageId AND StageName = '"+stage+"'"
		"StageNumber":
			return "SELECT count(*) as JumlahStage From TableStage"
		"StageSD":
			return "SELECT count(*) as SD from TableStage WHERE Tingkat = 'SD' GROUP BY  Tingkat"
		"StageSMP":
			return "SELECT count(*) as SMP from TableStage WHERE Tingkat = 'SMP' GROUP BY  Tingkat"
		"StageSMA":
			return "SELECT count(*) as SMA from TableStage WHERE Tingkat = 'SMA' GROUP BY  Tingkat"
		"StageNumberUnlocked":
			return "SELECT count(*) as JumlahStageUnlock From TableStage WHERE TableStage.Unlocked = 'Y'"
		"Highscore":
			if(stage != null):
				return "SELECT TableHighscore.HighScore FROM TableStage INNER JOIN TableHighscore WHERE TableStage.StageId = TableHighscore.StageId AND StageName = 'Stage"+String(stage)+"'"	
			return "SELECT TableHighscore.HighScore FROM TableHighscore ORDER BY TableHighscore.StageId"

func checkStageUnlocked(stage):
	var query = null
	var queryResult = null
	db = SQLite.new()
	db.path = dbPath
	db.open_db()
	query = _dbRequestChecker(stage, "UnlockedStage")
	db.query(query)
	queryResult = db.query_result
	if(!queryResult.size() == 0):
		return true
	return false

	
func insertDataToDB(stage, value):
	db = SQLite.new()
	db.path = dbPath
	db.open_db()
	var query = "UPDATE TableHighscore SET HighScore = "+String(value)+" WHERE StageId =(Select StageId From TableStage WHERE StageName = '"+stage+"')"
	db.query(query)
	db.close_db()
	

func unlockNewStage(stage):
	db = SQLite.new()
	db.path = dbPath
	db.open_db()
	var query = "UPDATE TableStage SET Unlocked = 'Y' WHERE StageId = 'S"+String(stage)+"'"
	db.query(query)
	db.close_db()

func resetDB():
	var oldDbPath = "res://Database/"
	var movePath = "user://Database/"
	var dir = Directory.new()
	
	dir.make_dir(movePath)
	if dir.open(oldDbPath) == OK:
		dir.list_dir_begin(true, true)
		var fileName = dir.get_next()
		while (fileName != ""):
			print(fileName)
			var tempOldPath = oldDbPath + fileName
			var tempNewPath = movePath + fileName
			dir.copy(tempOldPath, tempNewPath)
			fileName = dir.get_next()
		dir.list_dir_end()
	return true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
