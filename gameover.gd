extends CanvasLayer



func _ready() -> void:
    pass 
    
func restart_game():
    get_tree().change_scene_to_file("res://scenes/game.tscn")


func _process(delta: float) -> void:
    pass


func _on_button_pressed() -> void:
    restart_game()
