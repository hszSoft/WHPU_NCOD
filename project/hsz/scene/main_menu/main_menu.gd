extends Node2D

onready var start_button := $InterfaceLayer/Control/VBoxContainer/StartButton
onready var options_button := $InterfaceLayer/Control/VBoxContainer/OptionsButton
onready var exit_button := $InterfaceLayer/Control/VBoxContainer/ExitButton

func _on_StartButton_hover():
	$Sound/Select.play()

func _on_StartButton_press():
	$Sound/Press.play()

func _on_OptionsButton_hover():
	$Sound/Select.play()

func _on_OptionsButton_press():
	$Sound/Press.play()

func _on_ExitButton_hover():
	$Sound/Select.play()

func _on_ExitButton_press():
	$Sound/Press.play()
