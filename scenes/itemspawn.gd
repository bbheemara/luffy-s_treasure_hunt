extends Node2D

var spawner_position = []
var item = preload('res://scenes/items.tscn')

func _ready():
    randomize()
    spawner_position = $spawn.get_children()

func spawnitem():
    if spawner_position.size() == 0:
        return
    var index = randi() % spawner_position.size()
    var boat = item.instantiate()
    boat.global_position = spawner_position[index].global_position
    add_child(boat)

func _on_timer_timeout():
    spawnitem()
