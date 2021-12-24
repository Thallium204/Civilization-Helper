extends Resource
tool
class_name civ_ColorData

export(String) var name = ""
export(Texture) var image
export(Color) var color

func _to_string():
	return "[ColorData: "+name+"]"
