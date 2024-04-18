extends Area2D

#设置把一个东西推开的向量，防止重叠
func is_colliding():
	#返回一个array值，即返回所有碰撞的区域
	var areas = get_overlapping_areas()
	return areas.size() > 0

func get_push_vector():
	#返回一个array值，即返回所有碰撞的区域
	var areas = get_overlapping_areas()
	var push_vector = Vector2.ZERO
	if is_colliding(): #检测碰撞
		var area = areas[0] #获取第一个重叠的area,其他的忽略，即不需要检测array里的每一样东西
		#获取一个从它的位置到我们位置的一个向量
		push_vector = area.global_position.direction_to(global_position)
		#normalized()简单的说就是将向量的长度变为1，让距离保持一致，以免在对角线上移动时比水平或垂直移动快
		push_vector = push_vector.normalized()
	return push_vector  #如果和其他碰撞我们就会返回0
