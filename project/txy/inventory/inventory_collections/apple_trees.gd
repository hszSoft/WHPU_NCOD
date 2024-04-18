extends Node2D

export var state = "no apples"
export var player_in_area = false
var apple = preload("res://txy/inventory/inventory_collections/apple_collectable.tscn")
func _ready():
	if state == "no apples":
		$growth_timer.start()
		
func _process(delta):
	if state == "no apples":
		$AnimatedSprite2D.play("no apples")
	if state == "apples":
		$AnimatedSprite2D.play("apples")
		if player_in_area:
			if Input.is_action_just_pressed("e"):
				state = "no apples"
				$growth_timer.start()

func _on_Pickable_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true


func _on_Pickable_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false


func _on_growth_timer_timeout():
	if state == "no apples":
		state =  "apples"


