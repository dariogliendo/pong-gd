extends CharacterBody2D

@export var player = 0;
var left_action
var right_action

const speed = 1;
const max_speed = 0.5;

var acceleration = 0;
var window_dimensions
var size

func _ready():
	if not player:
		push_error('Se debe indicar un número de jugador 1 o 2')
		
	size = get_node("CollisionShape2D").get_shape().get_size()
	var window = get_window()
	window_dimensions = window.size
	
	if player == 1:
		left_action = "p1_left"
		right_action = "p1_right"
		position.y = 20
	if player == 2:
		left_action = "p2_left"
		right_action = "p2_right"
		position.y = window_dimensions.y - 20
	
	position.x = (window_dimensions.x / 2) - (size.x / 2)

func _physics_process(delta):
	# Moverse si está acelerado
	if acceleration:
		position.x += acceleration
		
	# Acelerar con controles
	if Input.is_action_pressed(left_action) and acceleration < max_speed:
		acceleration -= speed
	if Input.is_action_pressed(right_action) and acceleration > -max_speed:
		acceleration += speed
		
	# Frenar al soltar
	if not Input.is_action_pressed(left_action) and acceleration < 0:
		acceleration += speed
	if not Input.is_action_pressed(right_action) and acceleration > 0:
		acceleration -= speed

	# Chequear bordes
	if position.x < 0:
		acceleration = 0;
		position.x = 0
		
	if (position.x + size.x) > window_dimensions.x:
		acceleration = 0;
		position.x = window_dimensions.x - size.x
	
