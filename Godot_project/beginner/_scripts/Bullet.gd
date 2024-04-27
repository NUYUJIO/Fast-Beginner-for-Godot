extends Area2D

var travelled_distance = 0

func _physics_process(delta: float) -> void:
	const SPEED = 1000
	const RANGE = 1200
	
	# 让子弹往前直射
	# 在主工作区中旋转子弹，也会往前射
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	# 移动1200像素后销毁
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
