extends DetectionBox
class_name Hurtbox

signal hurt(hitbox)

func _ready():
	connect("area_entered", self, "_on_area_entered")

func _on_area_entered(hitbox):
	if not hitbox is DetectionBox:
		return
	if not enable or not hitbox.enable:
		return
	emit_signal("hurt", hitbox)

func set_enable(is_enable):
	.set_enable(is_enable)
	set_deferred("monitoring", is_enable)
