tool
extends Node

func focus_to_resource_type(focus_type):
	var trans = [0,1,0,0,2,3]
	return trans[focus_type]

const HEX_X_VECTOR = Vector2(162.0,0.0)
#var HEX_Y_VECTOR = HEX_X_VECTOR.rotated(PI/3.0)
const HEX_Y_VECTOR = Vector2(81.0,140.3)
const EX_Y_VECTOR = Vector2( 0.5, 0.866049 )

const ADJ_COORDS = [
	Vector2(1,0),
	Vector2(.5,1),
	Vector2(-.5,1),
	Vector2(-1,0),
	Vector2(-.5,-1),
	Vector2(.5,-1),
]

var ADJ_POSITIONS = [
	coord_to_position(ADJ_COORDS[0]),
	coord_to_position(ADJ_COORDS[1]),
	coord_to_position(ADJ_COORDS[2]),
	coord_to_position(ADJ_COORDS[3]),
	coord_to_position(ADJ_COORDS[4]),
	coord_to_position(ADJ_COORDS[5]),
]

const TILE_COORDS = [Vector2.ZERO] + ADJ_COORDS + [Vector2(1.5,-1),Vector2(1,-2),Vector2(2,-2)]

func get_tile_positions(tile_type) -> PoolVector2Array:
	var position_array = PoolVector2Array()
	for id in range(10):
		var position = coord_to_position(TILE_COORDS[id])
		position_array.append( position * Vector2(-2*tile_type+1,1) )
	return position_array

enum TileType{A,B}

static func snap_to_hex_grid(pos):
	var coord = position_to_coord(pos)
	#print(coord)
	return coord_to_position(coord)

static func position_to_coord(pos):
	var x_float = pos.x / HEX_X_VECTOR.x
	var y_float = pos.y / HEX_Y_VECTOR.y
	var y_int = int(round(y_float))
	var y_delta = abs(y_int % 2)
	var shifted_x_float = x_float + 0.5 * y_delta
	var shifted_x_int = int(round(shifted_x_float))
	var x_half = shifted_x_int - 0.5 * y_delta
	return Vector2(x_half,y_int)

static func coord_to_position(coord):
	return Vector2( coord.x*HEX_X_VECTOR.x , coord.y*HEX_Y_VECTOR.y )

var DIRECTIONS = PoolVector2Array([
	Vector2.RIGHT,
	Vector2.RIGHT.rotated(1*PI/3.0),
	Vector2.RIGHT.rotated(2*PI/3.0),
	Vector2.LEFT,
	Vector2.LEFT.rotated(1*PI/3.0),
	Vector2.LEFT.rotated(2*PI/3.0),
])


enum BarbarianID{A,B,C,D,E,F,G,H,I,J,K}

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

enum TerrainType{
	WATER,
	GRASSLAND,
	HILLS,
	FOREST,
	DERERT,
	MOUNTAINS,
	WONDER,
}

const TERRAIN_NAMES = "Water,Grassland,Hills,Forest,Desert,Mountains"
const TERRAIN_NAMES_PATHLIST = ["water","grassland","hills","forest","desert","mountains"]

enum FocusType{
	CULTURE,
	ECONOMY,
	GROWTH,
	INDUSTRY,
	MILITARY,
	SCIENCE,
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


enum EraType{
	ANCIENT,
	MEDIEVAL,
	MODERN
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

enum NaturalWonderType{
	NONE,
	CLIFFS_OF_DOVER,
	CRATER_LAKE,
	GALAPAGOS_ISLANDS,
	GOBUSTAN,
	GRAND_MESA,
	HA_LONG_BAY,
	MATO_TIPILA,
	MT_EVEREST,
	MT_KILIMANJARO,
	PANTANAL,
	THE_DEAD_SEA,
	TORRES_DEL_PAINE
}

enum WorldWonderType{
	ALHAMBRA,
	AMUDSEN_SCOTT,
	APADANA,
	BIG_BEN,
	CHICHEN_ITZA,
	COLOSSEUM,
	COLOSSUS,
	CRISTO_REDENTOR,
	EIFFEL_TOWER,
	ESTADIO_DO_MARACANA,
	FORBIDDEN_CITY,
	GREAT_LIBRARY,
	GREAT_LIGHTHOUSE,
	GREAT_ZIMBABWE,
	HANGING_GARDENS,
	HUEY_TEOCALLI,
	JEBEL_BARKAL,
	KILWA_KISIWANI,
	KREMLIN,
	MACHU_PICCHU,
	ORACLE,
	ORSZAGHAZ,
	OXFORD_UNIVERSITY,
	PENTAGON,
	PETRA,
	PORCELAIN_TOWER,
	POTALA_PALACE,
	PYRAMIDS,
	RUHR_VALLEY,
	STATUE_OF_LIBERTY,
	STONEHENGE,
	SYDNEY_OPERA_HOUSE,
	TAJ_MAHAL,
	TERRACOTA_ARMY,
	UNIVERSITY_OF_SANKORE,
	VENETIAN_ARSENAL,
}

const WORLD_WONDER_IDS_SORTED = PoolIntArray([
	WorldWonderType.HANGING_GARDENS,
	WorldWonderType.COLOSSEUM,
	WorldWonderType.STONEHENGE,
	WorldWonderType.TAJ_MAHAL,
	WorldWonderType.FORBIDDEN_CITY,
	WorldWonderType.CHICHEN_ITZA,
	WorldWonderType.SYDNEY_OPERA_HOUSE,
	WorldWonderType.EIFFEL_TOWER,
	WorldWonderType.CRISTO_REDENTOR,
	
	WorldWonderType.APADANA,
	WorldWonderType.COLOSSUS,
	WorldWonderType.GREAT_LIGHTHOUSE,
	WorldWonderType.KILWA_KISIWANI,
	WorldWonderType.GREAT_ZIMBABWE,
	WorldWonderType.MACHU_PICCHU,
	WorldWonderType.ESTADIO_DO_MARACANA,
	WorldWonderType.ORSZAGHAZ,
	WorldWonderType.BIG_BEN,
	
	WorldWonderType.TERRACOTA_ARMY,
	WorldWonderType.PETRA,
	WorldWonderType.JEBEL_BARKAL,
	WorldWonderType.ALHAMBRA,
	WorldWonderType.VENETIAN_ARSENAL,
	WorldWonderType.HUEY_TEOCALLI,
	WorldWonderType.STATUE_OF_LIBERTY,
	WorldWonderType.PENTAGON,
	WorldWonderType.RUHR_VALLEY,
	
	WorldWonderType.ORACLE,
	WorldWonderType.GREAT_LIBRARY,
	WorldWonderType.PYRAMIDS,
	WorldWonderType.POTALA_PALACE,
	WorldWonderType.PORCELAIN_TOWER,
	WorldWonderType.UNIVERSITY_OF_SANKORE,
	WorldWonderType.OXFORD_UNIVERSITY,
	WorldWonderType.AMUDSEN_SCOTT,
	WorldWonderType.KREMLIN,
])

const WONDER_CONTEXT = {
	FocusType.CULTURE : {
		EraType.ANCIENT:	[WorldWonderType.HANGING_GARDENS,WorldWonderType.COLOSSEUM,WorldWonderType.STONEHENGE],
		EraType.MEDIEVAL:	[WorldWonderType.TAJ_MAHAL,WorldWonderType.FORBIDDEN_CITY,WorldWonderType.CHICHEN_ITZA],
		EraType.MODERN:		[WorldWonderType.SYDNEY_OPERA_HOUSE,WorldWonderType.EIFFEL_TOWER,WorldWonderType.CRISTO_REDENTOR],
	},
	FocusType.ECONOMY : {
		EraType.ANCIENT:	[WorldWonderType.APADANA,WorldWonderType.COLOSSUS,WorldWonderType.GREAT_LIGHTHOUSE],
		EraType.MEDIEVAL:	[WorldWonderType.KILWA_KISIWANI,WorldWonderType.GREAT_ZIMBABWE,WorldWonderType.MACHU_PICCHU],
		EraType.MODERN:		[WorldWonderType.ESTADIO_DO_MARACANA,WorldWonderType.ORSZAGHAZ,WorldWonderType.BIG_BEN],
	},
	FocusType.MILITARY : {
		EraType.ANCIENT:	[WorldWonderType.TERRACOTA_ARMY,WorldWonderType.PETRA,WorldWonderType.JEBEL_BARKAL],
		EraType.MEDIEVAL:	[WorldWonderType.ALHAMBRA,WorldWonderType.VENETIAN_ARSENAL,WorldWonderType.HUEY_TEOCALLI],
		EraType.MODERN:		[WorldWonderType.STATUE_OF_LIBERTY,WorldWonderType.PENTAGON,WorldWonderType.RUHR_VALLEY],
	},
	FocusType.SCIENCE : {
		EraType.ANCIENT:	[WorldWonderType.ORACLE,WorldWonderType.GREAT_LIBRARY,WorldWonderType.PYRAMIDS],
		EraType.MEDIEVAL:	[WorldWonderType.POTALA_PALACE,WorldWonderType.PORCELAIN_TOWER,WorldWonderType.UNIVERSITY_OF_SANKORE],
		EraType.MODERN:		[WorldWonderType.OXFORD_UNIVERSITY,WorldWonderType.AMUDSEN_SCOTT,WorldWonderType.KREMLIN],
	},
}





