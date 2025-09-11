extends CharacterBody2D

const JUMP_SPEED : int = -1800

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    if is_on_floor():
            if Input.is_action_pressed("ui_accept"):
                velocity.y = JUMP_SPEED
                #$JumpSound.play()
            elif Input.is_action_pressed("ui_down"):
                $AnimatedSprite2D.play("default")
                $RunCol.disabled = true
            else:
                $AnimatedSprite2D.play("default")
    else:
        $AnimatedSprite2D.play("default")
        
    move_and_slide()
