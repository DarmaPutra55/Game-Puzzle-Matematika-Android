extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	_moveToUser()

func _moveToUser():
	var dbPath = "user://Database"
	var dir = Directory.new()
	var dirCheck = dir.dir_exists(dbPath)
	#print(dirCheck)
	if(!dirCheck):
		Database.resetDB()
	get_tree().change_scene("res://Scene/mainMenu.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
