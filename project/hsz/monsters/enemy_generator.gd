extends Node
class_name EnemyGenerator

export(Array, PackedScene) var enemy_list = []
export(Array, int) var weight_list = []
export var enemy_limit: int = 30

var total_weight: int = 0

export var enable: bool = true

export var enemy_parent_path: NodePath
onready var enemy_parent := get_node(enemy_parent_path) as Node2D

export var camera_path: NodePath
onready var camera := get_node(camera_path) as Camera2D

onready var spawn_regions: Array = []
	
func _ready():
	for child in get_children():
		if child is RectRegion:
			spawn_regions.push_back(child)
	for element in weight_list:
		total_weight += element
		
func select_enemy() -> Enemy:
	var rand_num = rand_range(0, total_weight)
	var current_num = 0
	for i in range(weight_list.size()):
		current_num += weight_list[i]
		if rand_num <= current_num:
			return enemy_list[i].instance()
	return null

func select_position() -> Vector2:
	var idx = randi() % spawn_regions.size()
	var spawn_region: RectRegion = spawn_regions[idx]
	return spawn_region.get_random_point()
	
func is_point_in_camera_view(point):
	var viewport_size = camera.get_viewport_rect().size
	var camera_position = camera.get_global_position() - viewport_size * 0.5 * camera.zoom
	var camera_end_position = camera_position + viewport_size * camera.zoom
	return point.x >= camera_position.x and point.x <= camera_end_position.x and point.y >= camera_position.y and point.y <= camera_end_position.y

func try_spawn_enemy():
	if enemy_parent.get_children().size() >= enemy_limit:
		return
	var position := select_position()
	if is_point_in_camera_view(position):
		return
	var enemy := select_enemy()
	enemy.position = position
	enemy.connect("death", GameScene.player_items, "_on_enemy_death")
	enemy_parent.add_child(enemy)

func _on_RandomTimer_timeout():
	if not enable:
		return
	try_spawn_enemy()
