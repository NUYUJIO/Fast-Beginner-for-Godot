extends Area2D


func _physics_process(delta: float) -> void:
	# get_overlapping_bodies()方法属于Area2D，将检测进入其范围的实体，并返回数组
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		#var target_enemy = enemies_in_range[0]
		var target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)
		# 好像不能攻击距离玩家最近的怪，而是攻击第一个进范围的怪
		# 枪初始位置在右边，但转到左侧后枪就倒过来了


func shoot():
	# 在文件夹中把文件拖进来即可显示路径
	# preload()是游戏开始就加载，load()是运行到这行代码再加载
	const BULLET = preload("res://_scenes/bullet.tscn")
	# 实例化
	var new_bullet = BULLET.instantiate()
	# 设置子弹的位置和朝向，从枪口射出
	# position相对于父节点，global_position是相对于root节点了
	# 记得将 shootingPoint 节点设为唯一名称
	new_bullet.global_position = %shootingPoint.global_position
	new_bullet.global_rotation = %shootingPoint.global_rotation	
	%shootingPoint.add_child(new_bullet)

func _on_timer_timeout() -> void:
	shoot()
