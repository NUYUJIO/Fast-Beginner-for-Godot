extends CharacterBody2D

var health = 3

'''
# 运行场景后可在左侧看到远程和本地，远程应该就是全局节点的排列了
# godot在创建节点前就运行了脚本，因此这里拿不到player节点，会报错
# 要用_ready()函数
#var player = get_node("/root/Game/Player")
var player
func _ready() -> void:
	player = get_node("/root/Game/Player") # 好像区分大小写
'''
# 语法糖，相当于上面那一段
@onready var player = get_node("/root/Game/Player")

func _ready() -> void:
	%Slime.play_walk()

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300.0
	move_and_slide()

func take_damage():
	health -= 1
	%Slime.play_hurt()
	
	if health == 0:
		queue_free()
		
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		# 这里的 global_position 没说，应该就是父节点的吧，难不成是根节点？
		smoke.global_position = global_position
