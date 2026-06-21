class_name MovementComponent extends Node

@export var body: CharacterBody2D
@export var speed:= 8.0

var dir: Vector2 = Vector2.ZERO
var to_jump:= false

func tick(delta: float) -> void:
	if !body:
		return
	
	body.velocity.x = dir.x * speed
	
	if not body.is_on_floor():
		body.velocity += body.get_gravity() * delta * gravity_multiplier
	
	#if to_jump and body.is_on_floor():
		#body.velocity.y = jump_velocity
	#to_jump = false
	
	body.move_and_slide()


func _on_input_component_jump_pressed():
	if body.is_on_floor():
		body.velocity.y = jump_velocity
