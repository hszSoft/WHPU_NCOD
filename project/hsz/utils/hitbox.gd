extends DetectionBox
class_name Hitbox

signal hit(hurtbox)

func _ready():
	connect("area_entered", self, "_on_area_entered")

func _on_area_entered(hurtbox):
	if not hurtbox is DetectionBox:
		return
	if not enable or not hurtbox.enable:
		return
	emit_signal("hit", hurtbox)

func set_enable(is_enable):
	.set_enable(is_enable)
	set_deferred("monitorable", is_enable)
