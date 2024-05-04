extends Node2D

onready var daogu_ap := $YSort/Daogu.get_node("AnimationPlayer") as AnimationPlayer

func _ready():
	daogu_ap.play("IdleUp")

func _on_Detection_find_target():
	Global.change_scene("res://twz/scene/outside.tscn")
