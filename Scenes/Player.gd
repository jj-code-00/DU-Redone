extends KinematicBody2D

var speed = 300
onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")
var movement = Vector2.ZERO

func _physics_process(delta):
	if movement != Vector2.ZERO:
		var blend = movement.normalized()
		animation_tree.set("parameters/Idle/blend_position", blend)
		animation_tree.set("parameters/Walk/blend_position", blend)
	if(Input.is_action_pressed("i_up")):
		movement = Vector2(0,-1*speed)
		animation_state.travel("Walk")
		move_and_slide(movement)
		
	if(Input.is_action_pressed("i_down")):
		movement = Vector2(0,1*speed)
		animation_state.travel("Walk")
		move_and_slide(movement)
		
	if(Input.is_action_pressed("i_left")):
		movement = Vector2(-1*speed,0)
		animation_state.travel("Walk")
		move_and_slide(movement)
		
	if(Input.is_action_pressed("i_right")):
		movement = Vector2(1*speed,0)
		animation_state.travel("Walk")
		move_and_slide(movement)
	if(!(Input.is_action_pressed("i_up") || Input.is_action_pressed("i_down") || Input.is_action_pressed("i_left") || Input.is_action_pressed("i_right"))):
		animation_state.travel("Idle")
