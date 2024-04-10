extends Area2D

var player = null

#能够发现角色的区域
func can_see_player():
	return player != null

#检测有角色进入区域--信号
func _on_PlayerDetectionZone_body_entered(body):
	player = body

#检测有角色离开区域--信号
func _on_PlayerDetectionZone_body_exited(body):
	player = null
