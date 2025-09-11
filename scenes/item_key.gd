extends Area2D

var speed = 200

func _process(delta):
    position.y += speed * delta
    if position.y > 600:
        queue_free()
