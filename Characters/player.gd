extends CharacterBody2D

class_name Player

@export var speed: float = 100.0

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var joystick_left: VirtualJoystick = $"../CanvasLayer/Virtual Joystick Left"
@onready var joystick_right: VirtualJoystick = $"../CanvasLayer/Virtual Joystick Right"

var move_direction: Vector2 = Vector2.ZERO
var sprite_direction: Vector2 = Vector2.DOWN

func _ready():
	animation_tree.active = true

func _process(delta):
	update_animation_parameters()

func _physics_process(delta):
	# Use joystick for movement if it's pressed, otherwise use keyboard inputs
	update_movement()

	if move_direction:
		velocity = move_direction * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func update_movement():
	if joystick_left.is_pressed:
		move_direction = joystick_left.output.normalized()
	else:
		move_direction = Input.get_vector("left", "right", "up", "down").normalized()
	
	if joystick_right.is_pressed:
		sprite_direction = joystick_right.output.normalized()
	else:
		sprite_direction = move_direction

func update_animation_parameters():
	if move_direction == Vector2.ZERO:
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_moving"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_moving"] = true

	if(Input.is_action_just_pressed("use")) or joystick_right.is_pressed:
		animation_tree["parameters/conditions/swing"] = true
	else:
		animation_tree["parameters/conditions/swing"] = false

	if sprite_direction != Vector2.ZERO:
		animation_tree["parameters/Idle/blend_position"] = sprite_direction
		animation_tree["parameters/Swing/blend_position"] = sprite_direction
		animation_tree["parameters/Walk/blend_position"] = sprite_direction
