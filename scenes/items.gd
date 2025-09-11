extends CharacterBody2D


var SPEED = 200

func _physics_process(delta):
    move_and_collide(Vector2(0, SPEED + delta))
