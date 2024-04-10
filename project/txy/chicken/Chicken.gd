extends KinematicBody2D

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 4

enum{
	IDLE,
	WANDER,
	CHASE
}

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

var state = CHASE
#设置变量引入某脚本内容
onready var sprite = $AnimatedSprite
onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone
onready var hurtbox = $Hurtbox
onready var softCollision = $SoftCollision
onready var wanderController = $WanderController

func _ready():
	#设置开始时的物体的随机状态，选用种子,脚本不一样种子也不一样，用randomize()（在player.gd  _ready()里）
	state = pick_random_state([IDLE, WANDER])

func _physics_process(delta):
	#设置摩擦
	knockback = knockback.move_toward(Vector2.ZERO,FRICTION * delta)
	knockback = move_and_slide(knockback)
	#状态树
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO,FRICTION * delta)
			seek_player()
			#选择漫游状态
			if wanderController.get_time_left() == 0:
				update_wander()
				
		WANDER:
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
			accelerate_towards_point(wanderController.target_position,delta)
			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
				update_wander()	
			
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				#获取指向玩家的向量
				var direction = global_position.direction_to(player.global_position)#(player.global_position - global_position).normalized()
				velocity = velocity.move_toward(-direction * MAX_SPEED, ACCELERATION * delta)
			else:
				state = IDLE
			sprite.flip_h = velocity.x < 0
	if softCollision.is_colliding():  #检测更新速度，使得他们无法碰撞到到一起
		velocity += softCollision.get_push_vector() * delta * 400  #这里数值越大他们越不可能碰撞到一起
	velocity = move_and_slide(velocity)

##获取指向该物体的向量和方向
func accelerate_towards_point(point,delta):
	var direction = global_position.direction_to(point)#(player.global_position - global_position).normalized()
	velocity = velocity.move_toward(direction * MAX_SPEED,ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0

#寻找玩家	
func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

#更新漫游状态	
func update_wander():
	state = pick_random_state([IDLE, WANDER]) #在剩余时间里随机选中一个状态
	wanderController.start_wander_timer(rand_range(1, 3))
	
#随机抽取
func pick_random_state(state_list): #他会从我们的state_list中随机抽取一个state
	state_list.shuffle()  #对state_list进行洗牌，然后选取第一个，也就是相当于随机抽取一个
	return state_list.pop_front()
	
#信号函数
func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
#	if stats.health <= 0:
#		queue_free()
#	print(stats.health)
	knockback = area.knockback_vector * 120
	hurtbox.create_hit_effect()


func _on_Stats_no_health():
	queue_free()
	#引用死亡特效场景
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
