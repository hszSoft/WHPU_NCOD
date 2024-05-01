extends Node2D

onready var start_button := $InterfaceLayer/Control/Main/StartButton
onready var options_button := $InterfaceLayer/Control/Main/OptionsButton
onready var exit_button := $InterfaceLayer/Control/Main/ExitButton

var first_to_game: bool = true

func to_main():
	$AnimationPlayer.play("ToMain")
	options_button.grab_focus()
	
func to_options():
	$AnimationPlayer.play("ToOptions")
	$InterfaceLayer/Control/Options/BackButton.grab_focus()

func _ready():
	start_button.grab_focus()
	
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if $InterfaceLayer/Control/Options.visible:
			$Sound/Press.play()
			to_main()

func _on_StartButton_hover():
	if first_to_game:
		first_to_game = false
	else:
		$Sound/Select.play()

func _on_StartButton_press():
	$Sound/Press.play()
	Global.change_scene("res://hsz/tests/test_outside.tscn")

func _on_OptionsButton_hover():
	$Sound/Select.play()

func _on_OptionsButton_press():
	$Sound/Press.play()
	to_options()

func _on_ExitButton_hover():
	$Sound/Select.play()

func _on_ExitButton_press():
	$Sound/Press.play()
	Global.quit_game()

func _on_BackButton_hover():
	$Sound/Select.play()

func _on_BackButton_press():
	$Sound/Press.play()
	to_main()

func _on_SFXSlider_value_changed(value):
	AudioServer.set_bus_volume_db(1, linear2db(value))
	$Sound/Select.play()

func _on_BGMSlider_value_changed(value):
	AudioServer.set_bus_volume_db(2, linear2db(value))

func _on_UseGamepad_hover():
	$Sound/Select.play()

func _on_UseGamepad_press():
	$Sound/Press.play()
	Global.use_gamepad = not Global.use_gamepad
	if Global.use_gamepad:
		$InterfaceLayer/Control/Options/UseGamepad.text = "手柄:开"
	else:
		$InterfaceLayer/Control/Options/UseGamepad.text = "手柄:关"

func _on_SFXSlider_focus_entered():
	$Sound/Select.play()

func _on_SFXSlider_mouse_entered():
	$Sound/Select.play()

func _on_BGMSlider_focus_entered():
	$Sound/Select.play()

func _on_BGMSlider_mouse_entered():
	$Sound/Select.play()
