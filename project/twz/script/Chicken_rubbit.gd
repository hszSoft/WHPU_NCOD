extends Area2D

var entered = false

func _on_Chicken_rubbit_body_entered(body):
	entered = true
	



func _on_Chicken_rubbit_body_exited(body):
	entered = false
	pass # Replace with function body.


func   _physics_process(delta):
	if entered and Input.is_action_just_pressed("pick"):
		$AudioStreamPlayer.play(0)
		yield($AudioStreamPlayer,"finished")
		queue_free()
