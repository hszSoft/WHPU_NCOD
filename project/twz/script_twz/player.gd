extends CharacterBody2D
var speed:=100
#角色移动
@onready var animation_player = $AnimationPlayer
@onready var graphic = $graphic
signal toggle_inventory


func _physics_process(delta):
	move()
	animation_handle()
	
func move() -> void:
	var direction1:=Input.get_axis("left","right")
	
	var direction2:=Input.get_axis("up","down")
	velocity.x=direction1*speed
	velocity.y=direction2*speed
	
	graphic.scale.x=-1 if direction1<0 else 1
	graphic.scale.y=-1 if direction2<0 else 1
	move_and_slide()
	
func animation_handle()->void:
	if velocity.x==0:
		animation_player.play("run")
	else:
		animation_player.play("idle")
	if velocity.y==0:
		animation_player.play("run")
	else:
		animation_player.play("idle")
		
func _unhandled_input(event):
	if Input.is_action_just_pressed("inventory"):
		toggle_inventory.emit()
















