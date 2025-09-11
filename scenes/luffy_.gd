extends CharacterBody2D

var speed = 400

func _physics_process(delta):
    velocity.x = 0  
    
    if Input.is_action_pressed("left"):
        velocity.x = -speed
        $AnimatedSprite2D.flip_h = false
    if Input.is_action_pressed("right"):
        velocity.x = speed
        $AnimatedSprite2D.flip_h = true
    
    move_and_slide()
    
    var screen_size = get_viewport().get_visible_rect().size
    position.x = clamp(position.x, 0, screen_size.x)
