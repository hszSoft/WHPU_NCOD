extends Node2D


onready var timer = $Timer
#onready var camera1 = $

export var monster_scenes = [
	preload("res://txy/monsters/cock/Cock.tscn"),
	preload("res://txy/monsters/hen/Hen.tscn"),
	preload("res://txy/monsters/killer_rabbit/Killer_Rabbit.tscn"),
	preload("res://txy/monsters/rabbit/Rabbit.tscn")
]

#怪物生成所在区域
export var spawn_area = Rect2(100, 100, 300, 300)

export var camera_path: NodePath
onready var camera: Camera2D = get_node(camera_path)

# 怪物最大数量
export var max_monsters = 10

# 当前怪物数量
export var current_monsters = 0

# 视线范围（简化为圆形区域）
export var sight_radius = 150
	
func _ready():
	timer = Timer.new()
	timer.wait_time = 2  # 每x秒尝试生成一次
	timer.autostart = true
	timer.connect("timeout", self, "_on_Timer_timeout")
	add_child(timer)

func _on_Timer_timeout():
	if current_monsters < max_monsters:
		spawn_monster()

# 怪物的随机生成
func spawn_monster():
	var can_spawn = false
	var position = Vector2.ZERO

	while not can_spawn:
		position.x = rand_range(spawn_area.position.x, spawn_area.position.x + spawn_area.size.x)
		position.y = rand_range(spawn_area.position.y, spawn_area.position.y + spawn_area.size.y)
		if position.distance_to(camera.global_position) > sight_radius:
			can_spawn = true

	# 随机选择一个怪物预制体
	var monster_scene = monster_scenes[randi() % monster_scenes.size()]
	var monster_instance = monster_scene.instance()
	monster_instance.global_position = position
	add_child(monster_instance)
	current_monsters += 1
