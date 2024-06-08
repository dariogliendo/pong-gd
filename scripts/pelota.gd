extends RigidBody2D

@export var initial_speed = 5
var acceleration = Vector2(0,0)

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	acceleration.x = rng.randi_range(0.1, 5)
	acceleration.y = rng.randi_range(0.1, 5)
	print(acceleration)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if acceleration:
		position += acceleration
