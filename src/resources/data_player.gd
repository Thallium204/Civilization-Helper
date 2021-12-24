extends Resource
tool
class_name civ_PlayerData

export(String) var name = "ai"
var id = 0
export(Resource) var color_data = color_data as civ_ColorData
export(Resource) var civilization_data = civilization_data as civ_CivilizationData

var focus_bar = null

func construct_focus_bar():
	pass

func _to_string():
	var string = "[PlayerData: name = " + name + " | "
	string += "color_data = " + color_data._to_string() + " | "
	string += "civilization_data = " + civilization_data._to_string() + " ]"
	return string
