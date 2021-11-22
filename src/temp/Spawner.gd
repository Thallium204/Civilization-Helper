extends GridContainer

var wonder_card_load = preload("res://src/WonderCard.tscn")

func _ready():
	for wonder_name in data.WONDER.keys():
		var WonderCard = gl.get_wonder_card(wonder_name)
		add_child(WonderCard)
