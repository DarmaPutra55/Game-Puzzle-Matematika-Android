extends Node2D
onready var hitSFX = get_node("HitSound")
onready var correctSFX = get_node("CorrectJingle")
signal hit;
signal movementDone;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var movementLock = false
var is_moving = false

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

func move(destination, moveSpeed):
	if(movementLock == false):
		var move_tween = get_node("Tween")
		move_tween.interpolate_property(self, "position", position, destination, moveSpeed, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		move_tween.start()	
		is_moving = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func start(pos):
	position = pos
	show()
	$Area2D/CollisionShape2D.disabled = false
	

func showMovementState():
	return is_moving

func answerPositionCheck(aPos):
	if position.x == aPos:
		correctSFX.play()

func _on_Area2D_area_entered(area):
	if area.areaType == "Asteroid":
		emit_signal("hit")
		hitSFX.play()
		#$Area2D/CollisionShape2D.set_deferred("disabled", true)


func _on_Tween_tween_all_completed():
	is_moving = false
	emit_signal("movementDone")
