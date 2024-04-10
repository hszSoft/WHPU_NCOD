extends KinematicBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_pressed("action_left"):
		$AnimationPlayer.play("RunLeft")
	elif Input.is_action_pressed("action_right"):
		$AnimationPlayer.play("RunRight")
	pass
