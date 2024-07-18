extends Node3D

@export var visual: MeshInstance3D

var rotateSpeed = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	visual.rotate_y(rotateSpeed * delta)


func _on_area_3d_body_entered(_body):
	pass # Replace with function body.


func _on_area_3d_body_exited(_body):
	GameEvents.increase_round()
	queue_free()
