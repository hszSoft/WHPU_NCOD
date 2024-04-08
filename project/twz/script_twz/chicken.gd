extends CharacterBody2D




var speed:=20
var range1=244
var target=position
func _process(delta):
	#随机生成一个目标点
	if position.distance_to(target)<5:
		target =Vector2(randf_range(20,35),randf_range(0,90))
	#计算到目标点的方向
	var direction =(target-position).normalized()
	#计算位移量
	@warning_ignore("shadowed_variable_base_class")
	var velocity=direction*speed*delta
	position+=velocity
	move_and_slide()
