extends Button
class_name NormalButton

export var hover_brightness: float = 1.1
export var press_brightness: float = 1.2

var is_hover: bool = false
var is_press: bool = false

signal hover
signal press

func _ready():
	connect("button_down", self, "_on_button_down")
	connect("button_up", self, "_on_button_up")
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")
	connect("focus_entered", self, "_on_mouse_entered")
	connect("focus_exited", self, "_on_mouse_exited")

func set_brightness(val):
	self_modulate.r = val
	self_modulate.g = val
	self_modulate.b = val

func _on_button_down():
	is_press = true
	emit_signal("press")
	set_brightness(press_brightness)

func _on_button_up():
	is_press = false
	if is_hover:
		set_brightness(hover_brightness)
	else:
		set_brightness(1.0)

func _on_mouse_entered():
	is_hover = true
	emit_signal("hover")
	set_brightness(hover_brightness)

func _on_mouse_exited():
	is_hover = false
	set_brightness(1.0)
