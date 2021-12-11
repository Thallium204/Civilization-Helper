extends Node2D

signal move_mode_movement(relative)

const space_load = preload("res://src/Space.tscn")
const MIN_ADJACENCIES_ALLOWED = 4

var move_mode = false setget set_move_mode
var move_drag = false

var pan_drag = false

var coord_rect = Rect2()
var space_coords = {} # {hex_coord : Space}
var spaces_moving = [] setget set_spaces_moving
var spaces_rotation = 0
var additional_exceptions = []

onready var camera = $Camera2D

func set_spaces_moving(new_spaces_moving):
	if new_spaces_moving.empty():
		for Space in spaces_moving:
			Space.move_mode = false
			disconnect("move_mode_movement",Space,"move_self")
			
	spaces_moving = new_spaces_moving
	
	for Space in spaces_moving:
		Space.move_mode = true
		connect("move_mode_movement",Space,"move_self")

func set_move_mode(new_move_mode):
	move_mode = new_move_mode
	set_spaces_pickable(not move_mode)

func _ready():
	randomize()

func add_coord(coord,Space):
	space_coords[coord] = Space
	coord_rect.position.x = min(coord_rect.position.x,coord.x)
	coord_rect.position.y = min(coord_rect.position.y,coord.y)
	coord_rect.end.x = max(coord_rect.end.x,coord.x)
	coord_rect.end.y = max(coord_rect.end.y,coord.y)

func trigger_detections():
	var spaces = get_tree().get_nodes_in_group("space")
	for space in spaces:
		if space is civ_Space:
			space.set_detect_adjacent_spaces()

func spawn_tile():
	
	if move_mode:
		return false
	
	self.move_mode = true
	
	spaces_moving = []
	var tile_data = res.get_random_tile_data()
	var spaces = []
	var tile_positions = gl.get_tile_positions(tile_data.tile_type)
	for id in 10:
		var Space:civ_Space = space_load.instance()
		Space.position = camera.position + tile_positions[id]
		Space.space_data = tile_data.space_data_array[id]
		add_space(Space)
		Space.z_index = VisualServer.CANVAS_ITEM_Z_MAX 
		spaces.append(Space)
	
	self.spaces_moving = spaces
	
	return true

func add_space(Space:civ_Space):
	add_child(Space)


func place_tile():
	
	if not move_mode:
		return
	
	if not is_valid_tile_placement():
		return
	
	# Place Spaces
	for Space in spaces_moving:
		if Space is civ_Space:
			var coord = gl.position_to_coord(Space.position)
			add_coord(coord,Space)
			Space.z_index = coord.y
	
	# Scan for enclosed void
	var enclosed_coords_array = get_enclosed_coords_array()
	for enclosed_coords in enclosed_coords_array:
		for coord in enclosed_coords:
			var Space:civ_Space = space_load.instance()
			Space.position = gl.coord_to_position(coord)
			Space.space_data = res.WATER_SPACE_DATA
			add_space(Space)
			add_coord(coord,Space)
	
	self.spaces_moving = []
	self.move_mode = false
	
	#trigger_detections()

func auto_spawn_and_place_tile():
	
	if move_mode:
		return false
	
	if not spawn_tile():
		return false
	
	var options = [] # [{position = Vector2(), degrees = 60}]
	options = get_tile_placement_options()
	if options.empty():
		return false
	var option = select_tile_option(options)
	move_tile_to_position(option.position)
	rotate_tile(option.degrees)
	place_tile()

func select_tile_option(options): # [{position = Vector2(), degrees = 60}]
	options.shuffle()
	return options[0]

func get_tile_placement_options():
	var options = [] # {position:degrees}
	for degrees in [0,60,120,180,240,300]:
		rotate_tile(degrees)
		for x_coord in range(coord_rect.position.x-4,coord_rect.end.x+5):
			for y_coord in range(coord_rect.position.y-4,coord_rect.end.y+4):
				var target_position = gl.coord_to_position(Vector2(x_coord+(y_coord % 2) * 0.5,y_coord))+Vector2(1,0)
				move_tile_to_position(target_position)
				if is_valid_tile_placement():
					options.append( {"position":target_position,"degrees":degrees} )
	return options

func get_x_range(from,to):
	var values = []
	var value = from
	while value <= to:
		values.append(value)
		value += 0.5
	return values

func move_tile_to_position(target_position):
	var relative_position = target_position - spaces_moving[0].position
	emit_signal("move_mode_movement",relative_position)

func is_valid_tile_placement():
	
	var adjacent_spaces = []
	for Space in spaces_moving:
		if Space is civ_Space:
			var coord = gl.position_to_coord(Space.position)
			# Check if space we're on is free
			if space_coords.has(coord):
				return false
			for rel_coord in gl.ADJ_COORDS:
				var check_coord = coord + rel_coord
				if space_coords.has(check_coord):
					var check_space = space_coords[check_coord]
					if not check_space in spaces_moving:
						if not check_space in adjacent_spaces:
							adjacent_spaces.append(check_space)
	
	# All spaces are valid
	
	# Check valid adjacencies
	if not space_coords.empty():
		if adjacent_spaces.size() < MIN_ADJACENCIES_ALLOWED:
			return false
	
	return true

func get_enclosed_coords_array():
	
	var pulsers = {}
	var void_coords = PoolVector2Array()
	for Space in spaces_moving:
		if Space is civ_Space:
			var coord = gl.position_to_coord(Space.position)
			for rel_coord in gl.ADJ_COORDS:
				var check_coord = coord + rel_coord
				# If check coord is void
				if not space_coords.has(check_coord) and not check_coord in void_coords:
					void_coords.append(check_coord)
					var pulse_id = pulsers.size()
					pulsers[pulse_id] = {"pulsed":[],"to_pulse":[check_coord]}
	
	var enclosed_array:Array = []
	var enclosed_checked = false
	while not enclosed_checked:
		
		for pulse_id in pulsers:
			#print("\n\n PULSING: ",pulse_id)
			var pulsed = pulsers[pulse_id].pulsed
			var being_pulsed = pulsers[pulse_id].to_pulse.duplicate()
			pulsers[pulse_id].to_pulse = []
			var to_pulse = pulsers[pulse_id].to_pulse
			
			for pulse_coord in being_pulsed:
				for rel_coord in gl.ADJ_COORDS:
					var check_coord = pulse_coord + rel_coord
					if not space_coords.has(check_coord):
						# check_coord is void
						if not check_coord in pulsed + being_pulsed + to_pulse:
							# check coord is valid
							for other_id in pulsers:
								var other_pulsed = pulsers[other_id].pulsed
								var other_to_pulse = pulsers[other_id].to_pulse
								if check_coord in other_pulsed + other_to_pulse:
									#stealing check_coord
									pulsed += other_pulsed.duplicate()
									to_pulse += other_to_pulse.duplicate()
									pulsers.erase(other_id)
									#print(pulse_id," erased: ",other_id)
							if not check_coord in pulsed + being_pulsed + to_pulse:
								to_pulse.append(check_coord)
			
			pulsed += being_pulsed.duplicate()
			
			pulsers[pulse_id].pulsed = pulsed
			pulsers[pulse_id].to_pulse = to_pulse
			
			#print(pulse_id,":",pulsed," <- ",to_pulse)
			#yield(get_tree().create_timer(.3), "timeout")
			
			if to_pulse.empty():
				#print("FOUND ENLOSED = ",pulsed)
				enclosed_array.append(pulsed.duplicate())
				pulsers.erase(pulse_id)
			
		if pulsers.size() == 1:
			return enclosed_array

func rotate_tile(degrees):
	
	if not move_mode:
		return
	
	var center_position = spaces_moving[0].position
	for Space in spaces_moving:
		var relative_pos:Vector2 = Space.position - center_position
		var new_rel_pos = relative_pos.rotated(deg2rad(int(degrees-spaces_rotation)%360))
		Space.position = center_position + new_rel_pos
	spaces_rotation = degrees

func set_spaces_pickable(is_pickable):
	var spaces = get_tree().get_nodes_in_group("space")
	for space in spaces:
		if space is civ_Space:
			space.CMPInterface.is_pickable = is_pickable


func _unhandled_key_input(event):
	
	if event is InputEventKey:
		
		if event.scancode == KEY_SPACE and event.pressed:
			
			spawn_tile()
			
		elif event.scancode == KEY_3 and event.pressed:
			
			auto_spawn_and_place_tile()
			
		elif event.scancode == KEY_Q and event.pressed:
			
			rotate_tile(spaces_rotation-60)
			
		elif event.scancode == KEY_E and event.pressed:
			
			rotate_tile(spaces_rotation+60)

func _unhandled_input(event):
	
	if event is InputEventMouseButton:
		
		if event.button_index == BUTTON_LEFT:
				
			move_drag = event.pressed
				
		if event.button_index == BUTTON_RIGHT:
			
			pan_drag = event.pressed
			
		elif event.button_index == BUTTON_WHEEL_UP:
			
			camera.zoom *= 1.0/1.1
			
		elif event.button_index == BUTTON_WHEEL_DOWN:
			
			camera.zoom *= 1.1/1.0
			
		elif event.button_index == BUTTON_LEFT and event.doubleclick:
			
			place_tile()
			
	elif event is InputEventMouseMotion:
		
		if move_mode and move_drag:
			
			emit_signal("move_mode_movement",event.relative*camera.zoom)
			
		elif pan_drag:
			
			camera.position -= event.relative * camera.zoom



