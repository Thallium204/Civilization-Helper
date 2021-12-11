tool
extends MeshInstance

export(bool) var generate = false setget set_generate

export(int) var resolution = 5 setget set_resolution
export(float) var size = 10.0 setget set_size
export(OpenSimplexNoise) var osn:OpenSimplexNoise = OpenSimplexNoise.new()

func set_generate(_new_generate):
	osn.seed = randi()
	generate_mesh()

func set_resolution(new_resolution):
	resolution = new_resolution
	generate_mesh()

func set_size(new_size):
	size = new_size
	generate_mesh()

func _ready():
	generate_mesh()
	osn.connect("changed",self,"generate_mesh")
	osn.octaves = 4
	osn.period = 20.0
	osn.persistence = 0.8


func create_vertices():
	
	var vertices = PoolVector3Array()
	
	for i in resolution:
		
		for j in resolution:
			
			var r = float(resolution)
			var vertex = Vector3.ZERO
			
			vertices.push_back(get_vertex(j+0,i+0))
			vertices.push_back(get_vertex(j+1,i+0))
			vertices.push_back(get_vertex(j+0,i+1))
			
			vertices.push_back(get_vertex(j+0,i+1))
			vertices.push_back(get_vertex(j+1,i+0))
			vertices.push_back(get_vertex(j+1,i+1))
	
	return vertices

func get_vertex(x_id,z_id):
	var vertex = Vector3(x_id/float(resolution), 0, z_id/float(resolution))
	vertex.y = get_height(vertex.x,vertex.z)
	return (vertex - Vector3(1,0,1)*.5) * size

func get_height(x,z):
	return (osn.get_noise_2d(x*50,z*50)+1)/2.0 * .4

func generate_mesh():
	
	var vertices = create_vertices()
	
	var arrays = []
	arrays.resize(ArrayMesh.ARRAY_MAX)
	arrays[ArrayMesh.ARRAY_VERTEX] = vertices
	
	var arr_mesh = ArrayMesh.new()
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	
	mesh = arr_mesh


