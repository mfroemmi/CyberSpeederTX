extends Node3D


# Node references
@export var ball: RigidBody3D
@export var car_mesh: MeshInstance3D
@export var spring_arm: Node3D

# Where to place the car mesh relative to the sphere
var sphere_offset = Vector3(0, -1.0, 0)
# Engine power
var acceleration = 350
# Turn amount, in degrees
var steering = 21.0
# How quickly the car turns
var turn_speed = 4
# Below this speed, the car doesn't turn
var turn_stop_limit = 2.75
# Amount to tilt the body on turns
var body_tilt = 60

# Variables for input values
var speed_input = 0
var rotate_input = 0

func _ready():
	pass
	
	
func _physics_process(_delta):
	if not GameEvents.is_race_running():
		return
		
	# Keep the car mesh aligned with the sphere
	car_mesh.transform.origin = ball.transform.origin# + sphere_offset
	# Accelerate based on car's forward direction
	ball.apply_central_force(-car_mesh.global_transform.basis.z * speed_input)


func _process(delta):
	if not GameEvents.is_race_running():
		return
		
	# Get accelerate/brake input
	speed_input = 0
	speed_input += Input.get_action_strength("brake")
	speed_input -= Input.get_action_strength("accelerate")
	speed_input *= acceleration
	# Get steering input
	rotate_input = 0
	rotate_input += Input.get_action_strength("steer_left")
	rotate_input -= Input.get_action_strength("steer_right")
	rotate_input *= deg_to_rad(steering)
	
	# rotate car mesh
	if ball.linear_velocity.length() > turn_stop_limit:
		var new_basis = car_mesh.transform.basis.rotated(Vector3.UP, rotate_input)
		car_mesh.transform.basis = car_mesh.transform.basis.slerp(new_basis, turn_speed * delta)
		car_mesh.transform = Transform3D(car_mesh.transform.basis.orthonormalized(), car_mesh.transform.origin)

		# tilt body for effect
		var t = -rotate_input * ball.linear_velocity.length() / body_tilt
		car_mesh.rotation_degrees.z = lerp(car_mesh.rotation_degrees.z, rad_to_deg(t), 10 * delta)
	
	spring_arm.global_position = car_mesh.global_position

func align_with_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform
