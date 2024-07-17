extends Node3D


# Node references
@export var ball: RigidBody3D
@export var car_mesh: MeshInstance3D
@export var spring_arm: Node3D

# Engine power
var acceleration = 250
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

	# Apply central force to the ball
	ball.apply_central_force(-car_mesh.global_transform.basis.z * speed_input)

	# Rotate car mesh based on steering input
	if ball.linear_velocity.length() > turn_stop_limit:
		var new_basis = car_mesh.transform.basis.rotated(Vector3.UP, rotate_input)
		car_mesh.transform.basis = car_mesh.transform.basis.slerp(new_basis, turn_speed * _delta)
		car_mesh.transform = Transform3D(car_mesh.transform.basis.orthonormalized(), car_mesh.transform.origin)

		# Tilt body for effect
		var t = -rotate_input * ball.linear_velocity.length() / body_tilt
		car_mesh.rotation_degrees.z = lerp(car_mesh.rotation_degrees.z, rad_to_deg(t), 10 * _delta)

	# Keep the car mesh aligned with the sphere
	car_mesh.global_position = ball.global_position
	
	# Synchronize spring_arm's position with car_mesh
	spring_arm.global_position = car_mesh.global_position

	# Get the current x rotation of the spring_arm
	var original_x_rotation = spring_arm.rotation.x

	# Apply the rotation offset to the spring_arm's basis
	var rotation_offset = Basis(Vector3.UP, deg_to_rad(180))
	spring_arm.global_transform.basis = car_mesh.global_transform.basis * rotation_offset

	# Restore the original x rotation
	spring_arm.rotation.x = original_x_rotation


func align_with_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform
