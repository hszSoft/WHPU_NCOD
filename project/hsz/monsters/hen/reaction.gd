extends Node2D

onready var hurt_sfx := $"../Hurt"

func _on_Hurtbox_hurt(hitbox):
	hurt_sfx.play()
