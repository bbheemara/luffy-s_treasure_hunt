extends Node2D

var item_scene : PackedScene = preload("res://scenes/coin.tscn")
var bomb_scene : PackedScene = preload("res://scenes/bomb.tscn")
var game_over_scene = preload("res://scenes/GameOver.tscn")
var player

@export var spawn_interval := 1.0
@export var spawn_count_each_tick := 1

var rng := RandomNumberGenerator.new()
var score = 0

func _ready():
    rng.randomize()
    player = $luffy_
    if $Timer == null:
        push_error("Timer node not found as a direct child named 'Timer'. Add a Timer under Main.")
        return
    var t = $Timer
    t.wait_time = spawn_interval
    t.one_shot = false
    t.autostart = true
    if not t.is_connected("timeout", Callable(self, "_on_Timer_timeout")):
        t.timeout.connect(Callable(self, "_on_Timer_timeout"))

func _on_Timer_timeout():
    for i in range(spawn_count_each_tick):
        if rng.randf() < 0.5:
           spawn_item()
        else:
            spawn_bomb()
            

func spawn_item():  
    
    var item_instance = item_scene.instantiate()
    add_child(item_instance)    
   

    var screen_size = get_viewport().get_visible_rect().size
    var x = rng.randf_range(0.0, screen_size.x)
    item_instance.position = Vector2(x, -20)
    
    item_instance.collected.connect(Callable(self, "_on_item_collected"))
    
func spawn_bomb():
    var bomb_instance = bomb_scene.instantiate()
    add_child(bomb_instance)
    
    var screen_size = get_viewport().get_visible_rect().size
    var x = rng.randf_range(0.0, screen_size.x)
    bomb_instance.position = Vector2(x, -20)
    
    
    
    
func _on_item_collected():
    score+=1
    $ScoreLabel.text="Score: %d" % score

func game_over():
    $Timer.stop()
    $ScoreLabel.text = "Game Over! Final Score: %d" % score
    player.set_process(false)
        
    # Show Game Over screen
    var go_screen = game_over_scene.instantiate()
    add_child(go_screen)
