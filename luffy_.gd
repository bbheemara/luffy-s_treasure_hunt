extends CharacterBody2D
var screen_size
var speed = 400


func _ready() -> void:
    screen_size = get_viewport().get_visible_rect().size
func _physics_process(delta):
    velocity.x = 0  
    
    if Input.is_action_pressed("left"):
        velocity.x = -speed
        $AnimatedSprite2D.flip_h = false
    if Input.is_action_pressed("right"):
        velocity.x = speed
        $AnimatedSprite2D.flip_h = true
    
    move_and_slide()
    
    var sprite_width = $AnimatedSprite2D.sprite_frames.get_frame_texture($AnimatedSprite2D.animation, $AnimatedSprite2D.frame).get_width()
    position.x = clamp(position.x, sprite_width / 2, screen_size.x - sprite_width / 2)
