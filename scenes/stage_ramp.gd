extends Node3D

@export var stage_number: int

@export var ramp1: CollisionShape3D
@export var ramp2: CollisionShape3D 

@export var mesh_instance1: MeshInstance3D
@export var transparency: float = 0.2
@export var transparency_full: float = 0.9

# Called when the node enters the scene tree for the first time.
func _ready():
	ramp1.disabled = true
	ramp2.disabled = true

	var material = mesh_instance1.get_active_material(0)
	if material and material is StandardMaterial3D:
		material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		material.albedo_color.a = transparency

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var stage_status 
	if stage_number == 1:
		stage_status = STAGE_STATUS.STAGE_ONE_COMPLETE
	else:
		stage_status = STAGE_STATUS.STAGE_TWO_COMPLETE
	
	if GameEvents.stageStatus == stage_status:
		ramp1.disabled = false
		ramp2.disabled = false

		var material = mesh_instance1.get_active_material(0)
		if material and material is StandardMaterial3D:
			material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
			material.albedo_color.a = transparency_full
	
