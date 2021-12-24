extends Node

const wonder_card_load = preload("res://src/WonderCard.tscn")
const focus_card_load = preload("res://src/FocusCard.tscn")

static func get_random_tile_data() -> civ_TileData:
	return (TILES+CAPITAL_TILES)[randi()%(TILES.size()+CAPITAL_TILES.size())]

const CAPITAL_SPAWN_IMAGE = preload("res://assets/cities/spawn.png")
const CITY_STATE_IMAGE = preload("res://assets/cities/city_default.png")

const COLORS = [
	preload("res://tres/colors/red.tres"),
	preload("res://tres/colors/blue.tres"),
	preload("res://tres/colors/green.tres"),
	preload("res://tres/colors/orange.tres"),
	preload("res://tres/colors/purple.tres"),
]

const CIVILIZATIONS = [
	preload("res://tres/civilizations/america.tres"),
	preload("res://tres/civilizations/egypt.tres"),
	preload("res://tres/civilizations/japan.tres"),
	preload("res://tres/civilizations/nubia.tres"),
	preload("res://tres/civilizations/sumeria.tres"),
]

const TILES = [
	preload("res://tres/tiles/1a.tres"),
	preload("res://tres/tiles/1b.tres"),
	preload("res://tres/tiles/2a.tres"),
	preload("res://tres/tiles/2b.tres"),
	preload("res://tres/tiles/3a.tres"),
	preload("res://tres/tiles/3b.tres"),
	preload("res://tres/tiles/4a.tres"),
	preload("res://tres/tiles/4b.tres"),
	preload("res://tres/tiles/5a.tres"),
	preload("res://tres/tiles/5b.tres"),
	preload("res://tres/tiles/6a.tres"),
	preload("res://tres/tiles/6b.tres"),
]

const CAPITAL_TILES = [
	preload("res://tres/tiles/7a.tres"),
	preload("res://tres/tiles/7b.tres"),
	preload("res://tres/tiles/9a.tres"),
	preload("res://tres/tiles/9b.tres"),
	preload("res://tres/tiles/11a.tres"),
	preload("res://tres/tiles/11b.tres"),
	preload("res://tres/tiles/16a.tres"),
	preload("res://tres/tiles/16b.tres"),
	preload("res://tres/tiles/17a.tres"),
	preload("res://tres/tiles/17b.tres"),
]

const WATER_SPACE_DATA:civ_SpaceData = preload("res://tres/spaces/water_space.tres")

static func get_focus_card(focus_card_name):
	var FocusCard = focus_card_load.instance()
	FocusCard.card_name = focus_card_name
	return FocusCard

static func get_wonder_card(wonder_id):
	var WonderCard = wonder_card_load.instance()
	WonderCard.world_wonder_data = get_world_wonder_tres(wonder_id)
	return WonderCard

const WORLD_WONDERS = [
	preload("res://tres/world_wonders/alhambra.tres"),
	preload("res://tres/world_wonders/amudsen-scott_research_station.tres"),
	preload("res://tres/world_wonders/apadana.tres"),
	preload("res://tres/world_wonders/big_ben.tres"),
	preload("res://tres/world_wonders/chichen_itza.tres"),
	preload("res://tres/world_wonders/colosseum.tres"),
	preload("res://tres/world_wonders/colossus.tres"),
	preload("res://tres/world_wonders/cristo_redentor.tres"),
	preload("res://tres/world_wonders/eiffel_tower.tres"),
	preload("res://tres/world_wonders/estadio_do_maracana.tres"),
	preload("res://tres/world_wonders/forbidden_city.tres"),
	preload("res://tres/world_wonders/great_library.tres"),
	preload("res://tres/world_wonders/great_lighthouse.tres"),
	preload("res://tres/world_wonders/great_zimbabwe.tres"),
	preload("res://tres/world_wonders/hanging_gardens.tres"),
	preload("res://tres/world_wonders/huey_teocalli.tres"),
	preload("res://tres/world_wonders/jebel_barkal.tres"),
	preload("res://tres/world_wonders/kilwa_kisiwani.tres"),
	preload("res://tres/world_wonders/kremlin.tres"),
	preload("res://tres/world_wonders/machu_picchu.tres"),
	preload("res://tres/world_wonders/oracle.tres"),
	preload("res://tres/world_wonders/orszaghaz.tres"),
	preload("res://tres/world_wonders/oxford_university.tres"),
	preload("res://tres/world_wonders/pentagon.tres"),
	preload("res://tres/world_wonders/petra.tres"),
	preload("res://tres/world_wonders/porcelain_tower.tres"),
	preload("res://tres/world_wonders/potala_palace.tres"),
	preload("res://tres/world_wonders/pyramids.tres"),
	preload("res://tres/world_wonders/ruhr_valley.tres"),
	preload("res://tres/world_wonders/statue_of_liberty.tres"),
	preload("res://tres/world_wonders/stonehenge.tres"),
	preload("res://tres/world_wonders/sydney_opera_house.tres"),
	preload("res://tres/world_wonders/taj_mahal.tres"),
	preload("res://tres/world_wonders/terracota_army.tres"),
	preload("res://tres/world_wonders/university_of_sankore.tres"),
	preload("res://tres/world_wonders/venetian_arsenal.tres"),
]

static func get_world_wonder_tres(world_wonder_type) -> civ_WorldWonderData:
	return res.WORLD_WONDERS[world_wonder_type]







