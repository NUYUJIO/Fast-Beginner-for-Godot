extends Node2D

func _ready() -> void:
	# 通过代码生成的怪物在本地节点树看不到，要运行场景后在远程树里才能看到
	spawn_mob()
	spawn_mob()
	spawn_mob()
	spawn_mob()	

func spawn_mob():
	var new_mob = preload("res://_scenes/mob.tscn").instantiate()
	# randf() 返回0到1之间的一个随机数？
	$Player/Path2D/PathFollow2D.progress_ratio = randf()
	new_mob.global_position = $Player/Path2D/PathFollow2D.global_position
	add_child(new_mob)


func _on_timer_timeout() -> void:
	spawn_mob()	


func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	# 取得场景树？
	get_tree().paused = true
