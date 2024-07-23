@tool
extends Node3D

@export var material: StandardMaterial3D
@onready var sign: MeshInstance3D = $PlaneSign


# Called when the node enters the scene tree for the first time.
func _ready():
	if material and sign:
		var mesh = sign.mesh
		if mesh:
			var material_instance = material.duplicate()
			mesh.surface_set_material(0, material_instance)
			sign.mesh = mesh
		else:
			print("No mesh assigned to the sign node.")
	else:
		print("Material or sign node is not properly set.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
