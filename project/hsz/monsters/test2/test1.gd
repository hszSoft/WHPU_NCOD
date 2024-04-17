extends Character

onready var sprite := $Sprite

func _process(delta):
	if velocity.x < 0:
		sprite.scale.x = -1
	else:
		sprite.scale.x = 1
