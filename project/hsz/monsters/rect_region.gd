extends Node2D
class_name RectRegion

export var width: float = 100
export var height: float = 100

func get_random_point():
	return Vector2(
		position.x + rand_range(-width / 2, width / 2),
		position.y + rand_range(-height / 2, height / 2)
	)
