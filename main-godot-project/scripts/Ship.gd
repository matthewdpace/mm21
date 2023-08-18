class_name Ship extends RigidBody3D


#@onready var rb:RigidBody3D = self
#@onready var mesh:MeshInstance3D = null
#@onready var colb:CollisionShape3D = null


signal playerlinvel(x, y, z)
signal playerrotvel(x, y, z)


var lastPos = Vector3(0.0, 0.0, 0.0)
var lastRot = Vector3(0.0, 0.0, 0.0)
var thrustVector = Vector3(0.0, 0.0, 0.0)
var rotateVector = Vector3(0.0, 0.0, 0.0)

var thrust = 600.0
# Called when the node enters the scene tree for the first time.
func _ready():
#	rb = $TestShip01
	
	pass # Replace with function body.


func _integrate_forces(state):
	# If this all works as of 2023-08-16, an official thank you to godot forums
	# user, wombatstampede (heh, good handle).  I will maintain that I could
	# have figured this out with enough temp .tscn files, nodes, notebook pages
	# etc.  But it's so much easier when someone not only explains the math,
	# the logic, but gives you sample projects to look at.
	# A secondary shoutout to the waybackmachine and the archive.org team for
	# ensuring access to this data after the godot forums moved and nuked their 
	# URLS.
	
	var delta = state.get_step()
	if Input.is_action_pressed("movement_backward"):
		self.apply_central_impulse(global_transform.basis.z * -1 * delta * thrust)
	if Input.is_action_pressed("movement_forward"):
		self.apply_central_impulse(global_transform.basis.z * 1 * delta *  thrust)
	if Input.is_action_pressed("movement_left"):
		self.apply_central_impulse(global_transform.basis.x * 1 * delta *  thrust)
	if Input.is_action_pressed("movement_right"):
		self.apply_central_impulse(global_transform.basis.x * -1 * delta *  thrust)
	if Input.is_action_pressed("movement_up"):
		self.apply_central_impulse(global_transform.basis.y * 1 * delta *  thrust)
	if Input.is_action_pressed("movement_down"):
		self.apply_central_impulse(global_transform.basis.y * -1 * delta *  thrust)
	
	if Input.is_action_pressed("engine_down"):
		self.thrust = self.thrust / 2
	if Input.is_action_pressed("engine_up"):
		self.thrust = self.thrust * 2
		
		
	if Input.is_action_pressed("roll_left"):
		self.apply_torque_impulse(Vector3(0, 0.0, -1.0) * delta *  thrust * 0.01)
	if Input.is_action_pressed("roll_right"):
		self.apply_torque_impulse(Vector3(0, 0.0, 1.0) * delta *  thrust * 0.01)
	if Input.is_action_pressed("pitch_up"):
		self.apply_torque_impulse(Vector3(1, 0.0, 0.0) * delta *  thrust * 0.01)
	if Input.is_action_pressed("pitch_down"):
		self.apply_torque_impulse(Vector3(-1, 0.0, 0.0) * delta *  thrust * 0.01)
	if Input.is_action_pressed("yaw_left"):
		self.apply_torque_impulse(Vector3(0, 1.0, 0.0) * delta *  thrust * 0.01)
	if Input.is_action_pressed("yaw_right"):
		self.apply_torque_impulse(Vector3(0, -1.0, 0.0) * delta *  thrust * 0.01)
	
	
		
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
