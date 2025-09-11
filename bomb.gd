extends Area2D
@export var fall_speed := 330.0

func _ready():
    connect("body_entered", Callable(self, "_on_body_entered"))

func _process(delta):
    position.y += fall_speed * delta
    var screen_size = get_viewport().get_visible_rect().size
    if position.y > screen_size.y + 50:
        queue_free()

func _on_body_entered(body):
    if body.is_in_group("player"):
      get_tree().call_group("game","game_over")
      
