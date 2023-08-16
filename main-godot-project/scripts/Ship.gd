class_name Ship extends RigidBody3D


#@onready var rb:RigidBody3D = self
#@onready var mesh:MeshInstance3D = null
#@onready var colb:CollisionShape3D = null


signal playerlinvel(x, y, z)
signal playerrotvel(x, y, z)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var lastPos = Vector3(0.0, 0.0, 0.0)
var lastRot = Vector3(0.0, 0.0, 0.0)
var thrust = 600.0
# Called when the node enters the scene tree for the first time.
func _ready():
#	rb = $TestShip01
	
	pass # Replace with function body.


func _integrate_forces(state):
	#print(delta)
	var delta = state.get_step()
	if Input.is_action_pressed("movement_backward"):
		self.apply_central_impulse(Vector3.FORWARD * delta * thrust)
	if Input.is_action_pressed("movement_forward"):
		self.apply_central_impulse(Vector3.BACK * delta *  thrust)
	if Input.is_action_pressed("movement_left"):
		self.apply_central_impulse(Vector3.RIGHT * delta *  thrust)
	if Input.is_action_pressed("movement_right"):
		#print("right")
		self.apply_central_impulse(Vector3.LEFT * delta *  thrust)
	if Input.is_action_pressed("movement_up"):
		self.apply_central_impulse(Vector3.UP * delta *  thrust)
	if Input.is_action_pressed("movement_down"):
		self.apply_central_impulse(Vector3.DOWN * delta *  thrust)
	
	if Input.is_action_pressed("engine_down"):
		self.thrust = self.thrust / 2
	if Input.is_action_pressed("engine_up"):
		self.thrust = self.thrust * 2
	if Input.is_action_pressed("roll_left"):
		self.apply_torque_impulse(Vector3(0, 0.0, -1.0) * delta *  thrust * 0.01)
	if Input.is_action_pressed("roll_right"):
		self.apply_torque_impulse(Vector3(0, 0.0, 1.0) * delta *  thrust * 0.01)
		
	var xvel = self.position.x - lastPos.x / delta 
	var yvel = self.position.y - lastPos.y / delta
	var zvel = self.position.z - lastPos.z / delta
	
	var xrot = self.rotation.x - lastRot.x / delta
	var yrot = self.rotation.y - lastRot.y / delta
	var zrot = self.rotation.z - lastRot.z / delta
	
	playerlinvel.emit(xvel, yvel, zvel)
	playerrotvel.emit(xrot, yrot, zrot)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
