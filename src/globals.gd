tool
extends Node

var wonder_card_load = preload("res://src/WonderCard.tscn")
var focus_card_load = preload("res://src/FocusCard.tscn")

func get_wonder_card(wonder_name):
	var WonderCard = wonder_card_load.instance()
	WonderCard.wonder_name = wonder_name
	return WonderCard

func get_focus_card(focus_card_name):
	var FocusCard = focus_card_load.instance()
	FocusCard.card_name = focus_card_name
	return FocusCard

func focus_to_resource_type(focus_type):
	var trans = [0,1,0,0,2,3]
	return trans[focus_type]


enum {
	GOVERMENT_REPUBLIC,
	GOVERMENT_OLIGARCHY,
	GOVERMENT_MONARCHY,
	GOVERMENT_COMMUNISM,
	GOVERMENT_AUTOCRACY,
	GOVERMENT_DEMOCRACY,
}

const GOVERNMENT_NAMES = "Republic,Oligarchy,Monarchy,Communism,Autocracy,Democracy"
const GOVERNMENT_NAMES_PATHLIST = ["Republic","Oligarchy","Monarchy","Communism","Autocracy","Democracy"]

enum {
	TERRAIN_TYPE_WATER,
	TERRAIN_TYPE_GRASSLAND,
	TERRAIN_TYPE_HILLS,
	TERRAIN_TYPE_FOREST,
	TERRAIN_TYPE_DERERT,
	TERRAIN_TYPE_MOUNTAINS,
}

const TERRAIN_NAMES = "Water,Grassland,Hills,Forest,Desert,Mountains"
const TERRAIN_NAMES_PATHLIST = ["water","grassland","hills","forest","desert","mountains"]

enum {
	FOCUS_CULTURE,
	FOCUS_ECONOMY,
	FOCUS_GROWTH,
	FOCUS_INDUSTRY,
	FOCUS_MILITARY,
	FOCUS_SCIENCE,
}

const FOCUS_NAMES = "Culture,Economy,Growth,Industry,Military,Science"
const FOCUS_NAMES_PATHLIST = ["culture","economy","growth","industry","military","science"]

const FOCUS_COLOR = PoolColorArray([
	Color("401568"),
	Color("888c51"),
	Color.white,
	Color.white,
	Color("901111"),
	Color("16184b"),
])

enum {
	PLAYER_RED,
	PLAYER_ORANGE,
	PLAYER_BLUE,
	PLAYER_GREEN,
	PLAYER_PURPLE
}

const PLAYER_NAMES = "Red,Orange,Blue,Green,Purple"

const PLAYER_COLOR = PoolColorArray([
	Color("f53232"),
	Color("ff824b"),
	Color("71f9e9"),
	Color("91fda5"),
	Color("ca91fd"),
])


enum {
	TECH_LEVEL_0,
	TECH_LEVEL_I,
	TECH_LEVEL_II,
	TECH_LEVEL_III,
	TECH_LEVEL_IV,
}

const TECH_NAMES = "0,I,II,III,IV"
const TECH_NAMES_LIST = ["0","I","II","III","IV"]


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











