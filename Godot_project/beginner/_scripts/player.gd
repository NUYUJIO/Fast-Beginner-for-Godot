extends CharacterBody2D

signal health_depleted

var health = 100.0

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left","move_right",
	"move_up","move_down")
	velocity = direction * 600
	move_and_slide()
	# print_debug("running")
	if velocity.length() > 0:
		# 右键节点设为唯一名称，节点旁出现一个 % ，就不会因为改变节点关系而报错
		# 设为唯一名称，godot就会自动寻找
		# 而且godot会在游戏开始时存储它，不用每次调用都去寻找
		%HappyBoo.play_walk_animation()
		#$HappyBoo.play_walk_animation()
		# 语法糖，相当于：
		#get_node(HappyBoo).play_walk_animation()
		# 如果是子节点的子节点，可能取不到。也可从全局节点路径来获得
	else:
		%HappyBoo.play_idle_animation()
		
	const DAMAGE_RATE = 5.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		if health <= 0.0:
			health_depleted.emit()
