extends CharacterBody2D

var speed = 200

func _physics_process(delta):
    velocity.x = 0  
    
    if Input.is_action_pressed("left"):
        velocity.x = -speed
        $AnimatedSprite2D.flip_h = false
    if Input.is_action_pressed("right"):
        velocity.x = speed
        $AnimatedSprite2D.flip_h = true
    
    move_and_slide()
