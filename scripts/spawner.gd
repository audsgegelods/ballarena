extends Node2D

# Spawning
var minSpawnRadius: float = 200
var maxSpawnRadius: float = 500
@onready var spawnTimer = $SpawnTimer

@onready var enemy = preload("res://Scenes/enemy.tscn")


func _ready() -> void:
	position = Vector2(randomCoord(), randomCoord())
	spawnEnemy()
	spawnTimer.start()

func randomCoord() -> float:
	var value = randf_range(minSpawnRadius, maxSpawnRadius)
	var sign = [1, -1].pick_random()
	return sign * value

func spawnEnemy() -> void:
	var newEnemy = enemy.instantiate()
	get_tree().current_scene.add_child(newEnemy)
	newEnemy.global_position = global_position
	position = Vector2(randomCoord(), randomCoord())

func _on_spawn_timer_timeout() -> void:
	spawnEnemy()
