tool
extends Spatial

export(Mesh) var mesh
export(bool) var add_collider
export(Shape) var collision_shape

var MM := MultiMesh.new()
var MMI := MultiMeshInstance.new()
var body: StaticBody
var collider: CollisionShape

func _enter_tree():
	pass

func _ready():
	if add_collider:
		body = StaticBody.new()
		collider = CollisionShape.new()
		if collision_shape == null:
			collider.shape = mesh.create_convex_shape()
		else:
			collider.shape = collision_shape
		body.add_child(collider)
	
	MM.transform_format = 1
	MM.instance_count = self.get_child_count()
	MM.mesh = mesh
	MMI.multimesh = MM
	
	var idx = 0
	for node in self.get_children():
		var pos = node.global_transform
		MM.set_instance_transform(idx, pos)
		idx += 1
		node.queue_free()
		
		if add_collider:
			var b = body.duplicate()
			b.global_transform = pos
			add_child(b)
	
	self.add_child(MMI)
