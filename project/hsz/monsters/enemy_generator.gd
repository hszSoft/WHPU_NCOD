extends Node2D
class_name EnemyGenerator

export(Array, PackedScene) var enemy_list = []
export var spawn_region_width: float
export var spawn_region_height: float
export var enable: bool = true

export var enemy_parent_path: NodePath
onready var enemy_parent := get_node(enemy_parent_path) as Node2D

export var scoreboard_path: NodePath
onready var scoreboard := get_node(scoreboard_path) as Scoreboard

func select_enemy() -> PackedScene:
	var idx = randi() % enemy_list.size()
	return enemy_list[idx]

func select_position() -> Vector2:
	var position_x = position.x + rand_range(-spawn_region_width / 2, spawn_region_width / 2)
	var position_y = position.y + rand_range(-spawn_region_height / 2, spawn_region_height / 2)
	return Vector2(position_x, position_y)

func ready():
	for child in get_children():
		print(child.name)

func _on_RandomTimer_timeout():
	if not enable:
		return
	var instanced_enemy: Enemy = select_enemy().instance()
	instanced_enemy.position = select_position()
	instanced_enemy.connect("death", scoreboard, "_on_enemy_death")
	enemy_parent.add_child(instanced_enemy)
