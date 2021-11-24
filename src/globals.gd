tool
extends Node

var wonder_card_load = preload("res://src/WonderCard.tscn")

func get_wonder_card(wonder_name):
	var WonderCard = wonder_card_load.instance()
	WonderCard.wonder_name = wonder_name
	return WonderCard

func get_focus_image(focus_type):
	return load("res://assets/focus types/"+FOCUS_NAMES_PATHLIST[focus_type]+".png")

func get_resource_image(resource_type):
	return load("res://assets/resources/"+RESOURCE_NAMES_PATHLIST[resource_type]+".png")

func get_resource_image_by_focus_type(focus_type):
	return get_resource_image(focus_type)

enum {
	FOCUS_CULTURE,
	FOCUS_ECONOMY,
	FOCUS_MILITARY,
	FOCUS_SCIENCE,
}

const FOCUS_NAMES = "Culture,Economy,Military,Science"
const FOCUS_NAMES_PATHLIST = ["culture","economy","military","science"]

const FOCUS_COLOR = PoolColorArray([
	Color("401568"),
	Color("888c51"),
	Color("901111"),
	Color("16184b"),
])



enum {
	ERA_ANCIENT,
	ERA_MEDIEVAL,
	ERA_MODERN,
}

const ERA_NAMES = "Ancient Era,Medieval Era,Modern Era"
const ERA_NAMES_LIST = ["Ancient Era","Medieval Era","Modern Era"]


enum {
	RESOURCE_MARBLE,
	RESOURCE_DIAMOND,
	RESOURCE_OIL,
	RESOURCE_MERCURY,
}

const RESOURCE_NAMES = "Marble,Diamond,Oil,Mercury"
const RESOURCE_NAMES_PATHLIST = ["marble","diamond","oil","mercury"]


const WONDER_CONTEXT = {
	FOCUS_CULTURE : {
		ERA_ANCIENT:	["Hanging Gardens","Colosseum","Stonehenge"],
		ERA_MEDIEVAL:	["Taj Mahal","Forbidden City","Chichen Itza"],
		ERA_MODERN:		["Sydney Opera House","Eiffel Tower","Cristo Redentor"],
	},
	FOCUS_ECONOMY : {
		ERA_ANCIENT:	["Apadana","Colossus","Great Lighthouse"],
		ERA_MEDIEVAL:	["Kilwa Kisiwani","Great Zimbabwe","Machu Pichu"],
		ERA_MODERN:		["Estadio do Maracana","Orszaghaz","Big Ben"],
	},
	FOCUS_MILITARY : {
		ERA_ANCIENT:	["Terracota Army","Petra","Jebel Barkal"],
		ERA_MEDIEVAL:	["Alhambra","Venetian Arsenal","Huey Teocalli"],
		ERA_MODERN:		["Statue of Liberty","Pentagon","Ruhr Valley"],
	},
	FOCUS_SCIENCE : {
		ERA_ANCIENT:	["Oracle","Great Library","Pyramids"],
		ERA_MEDIEVAL:	["Potala Palace","Porcelain Tower","University of Sankore"],
		ERA_MODERN:		["Oxford University","Amundsen-Scott Research Station","Kremlin"],
	},
}











