extends Control

onready var era_label = $EraPanel/Label

onready var stack_data = {
	gl.FocusType.CULTURE : {
		"stack":[],
		"timeline":[0],
		"slot":$HBoxCards/Culture,
		"button":$HBoxBuild/Culture,
		"card":null
	},
	gl.FocusType.ECONOMY : {
		"stack":[],
		"timeline":[0],
		"slot":$HBoxCards/Economy,
		"button":$HBoxBuild/Economy,
		"card":null
	},
	gl.FocusType.MILITARY : {
		"stack":[],
		"timeline":[0],
		"slot":$HBoxCards/Military,
		"button":$HBoxBuild/Military,
		"card":null
	},
	gl.FocusType.SCIENCE : {
		"stack":[],
		"timeline":[0],
		"slot":$HBoxCards/Science,
		"button":$HBoxBuild/Science,
		"card":null
	},
}

func _ready():
	randomize()
	prepare_stacks()
	read_timeline()


func prepare_stacks():
	var wonder_context = gl.WONDER_CONTEXT.duplicate(true)
	for focus_type in stack_data.keys():
		var dat = stack_data[focus_type]
		dat.stack = create_stack(focus_type,wonder_context)
		dat.timeline = [0]

func create_stack(focus_type,context):
	var temp_stack:Array = []
	var main_stack = []
	
	temp_stack = context[focus_type][gl.EraType.ANCIENT]
	temp_stack.shuffle()
	temp_stack.pop_front()
	main_stack += temp_stack
	
	temp_stack = context[focus_type][gl.EraType.MEDIEVAL]
	temp_stack.shuffle()
	temp_stack.pop_front()
	main_stack += temp_stack
	
	temp_stack = context[focus_type][gl.EraType.MODERN]
	temp_stack.shuffle()
	main_stack += temp_stack
	
	return main_stack

func read_timeline():
	var latest_era = gl.EraType.ANCIENT
	for focus_type in stack_data.keys():
		var dat = stack_data[focus_type]
		var wonder_index = int(floor(dat.timeline[-1] / 2.0))
		var discount = -int(dat.timeline[-1] % 2)
		var wonder_id = get_wonder_id_from_stack(dat.stack,wonder_index)
		make_current(wonder_id,discount,dat)
		if dat.card:
			latest_era = max(latest_era,dat.card.world_wonder_data.era_type)
		else:
			latest_era = gl.EraType.MODERN
	update_era_type_UI(latest_era)
	update_build_UI()

func get_wonder_id_from_stack(stack,index):
	if index >= stack.size():
		return null
	else:
		return stack[index]

func make_current(wonder_id,discount,dat):
	if dat.card:
		dat.card.free()
	dat.card = null
	if wonder_id is int:
		dat.card = res.get_wonder_card(wonder_id)
		dat.card.cost_mod = discount
		dat.slot.add_child(dat.card)

func progress_stacks():
	for focus_type in stack_data.keys():
		var dat = stack_data[focus_type]
		dat.timeline.append(dat.timeline[-1] + 1)
	read_timeline()

func build_wonder(focus_type):
	for pot_focus_type in stack_data.keys():
		var dat = stack_data[pot_focus_type]
		if pot_focus_type == focus_type:
			dat.timeline.append(int(ceil(dat.timeline[-1]/2.0 + 0.5)*2))
		else:
			dat.timeline.append(dat.timeline[-1])
	read_timeline()

func regress_timeline():
	for focus_type in stack_data.keys():
		var dat = stack_data[focus_type]
		if dat.timeline.size() > 1:
			dat.timeline.pop_back()
	read_timeline()

func update_era_type_UI(latest_era):
	if era_label:
		era_label.text = gl.ERA_NAMES_LIST[latest_era]

func _on_Progress_pressed():
	progress_stacks()
	update_undo_UI()


func _on_build_pressed(focus_type):
	build_wonder(focus_type)
	update_undo_UI()


func _on_Undo_pressed():
	regress_timeline()
	update_undo_UI()


func update_undo_UI():
	$Undo.disabled = (stack_data[0].timeline.size() == 1)

func update_build_UI():
	for focus_type in stack_data:
		var dat = stack_data[focus_type]
		dat.button.disabled = (dat.card == null)

func _on_Reset_pressed():
	var SPEED = 6.0
	var ITER = 4.0
	able_buttons(false)
	for i in int(ITER):
		var array = []
		for focus_type in gl.WONDER_CONTEXT.keys():
			var context = gl.WONDER_CONTEXT[focus_type]
			var list = context[gl.EraType.ANCIENT] + context[gl.EraType.MEDIEVAL] + context[gl.EraType.MODERN]
			list.shuffle()
			array.append(list)
		for pos in array[0].size():
			for focus_type in gl.WONDER_CONTEXT.keys():
				var actual_index = focus_type
				if actual_index in [4,5]:
					actual_index -= 2
				make_current(array[actual_index][pos],-1,stack_data[focus_type])
				yield(get_tree().create_timer(1.0/SPEED/4.0/7.0), "timeout")
	prepare_stacks()
	read_timeline()
	able_buttons(true)
	_on_Lock_toggled($Lock.pressed)


func able_buttons(able):
	$Undo.disabled = not able
	$Reset.disabled = not able
	$HBoxBuild/Culture.disabled = not able
	$HBoxBuild/Economy.disabled = not able
	$HBoxBuild/Military.disabled = not able
	$HBoxBuild/Science.disabled = not able
	$Progress.disabled = not able
	if able:
		update_undo_UI()
		update_build_UI()

func _on_Lock_toggled(button_pressed):
	able_buttons(not button_pressed)
