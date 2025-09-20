extends Node2D

@export var item_scene: PackedScene
@export var bomb_scene: PackedScene
@export var game_over_scene: PackedScene

var player
@export var spawn_interval := 1.0
@export var spawn_count_each_tick := 1
var rng := RandomNumberGenerator.new()
var score = 0

func _ready():
    rng.randomize()
    player = $luffy_
    add_to_group("game")
    var t = $Timer
    if t == null:
        push_error("Timer node not found! Add a Timer as child.")
        return
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
    item_instance.position = Vector2(rng.randf_range(0, screen_size.x), -20)
    item_instance.collected.connect(Callable(self, "_on_item_collected"))

func spawn_bomb():
    var bomb_instance = bomb_scene.instantiate()
    add_child(bomb_instance)
    var screen_size = get_viewport().get_visible_rect().size
    bomb_instance.position = Vector2(rng.randf_range(0, screen_size.x), -20)
    bomb_instance.hit_player.connect(Callable(self, "game_over"))

func _on_item_collected():
    score += 1
    $ScoreLabel.text = "Score: %d" % score

func game_over():
    $Timer.stop()
    $ScoreLabel.text = "Game Over! Final Score: %d" % score
    player.set_process(false)
    var go_screen = game_over_scene.instantiate()
    add_child(go_screen)
