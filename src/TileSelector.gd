extends Control

const Number_load = preload("res://src/Number.tscn")
const spawn_numbers = [7,9,11,16,17]
const wonder_numbers = [1,2,4,13,18,19]
const state_numbers = [6,12,14,15,20,21]
const barb_numbers = [1,2,3,4,5,10,11,12,15,18,20]

const marble_numbers = 	[1,3,6,10,11,13,14,15,16,18,21]
const diamond_numbers = [1,2,4,5,7,8,9,10,11,13,19,20]
const oil_numbers = 	[2,3,5,9,10,13,14,15,16,17,18,19]
const mercury_numbers = [2,3,4,5,7,8,12,17,18,20]

export(Color) var color_spawn
export(Color) var color_normal

const tile_display_order = [1,2,3,4,5,6,8,10,12,13,14,15,18,19,20,21,7,9,11,16,17]

var spawn_array = []
var normal_array = []

func _ready():
	randomize()
	generate_numbers()


func generate_numbers():
	clear_UI()
	spawn_array = []
	normal_array = []
	for number in tile_display_order:
		var Number = Number_load.instance()
		Number.get_node("HBoxTop/Label").text = str(number)
		
		Number.get_node("BG").color = color_normal
		if number in spawn_numbers:
			Number.get_node("BG").color = color_spawn
			spawn_array.append(Number)
		else:
			normal_array.append(Number)
		
		Number.get_node("HBoxTop/Type").text = ""
		if number in wonder_numbers:
			Number.get_node("HBoxTop/Type").text += "(W)"
		elif number in state_numbers:
			Number.get_node("HBoxTop/Type").text += "(S)"
		
		Number.get_node("HBoxTop/Barbarian").modulate.a = int(number in barb_numbers)
		
		Number.get_node("HBoxBottom/Marble").visible = (number in marble_numbers)
		Number.get_node("HBoxBottom/Diamond").visible = (number in diamond_numbers)
		Number.get_node("HBoxBottom/Oil").visible = (number in oil_numbers)
		Number.get_node("HBoxBottom/Mercury").visible = (number in mercury_numbers)
		
		$VBoxStack.add_child(Number)


func clear_UI():
	$ButtonNormal.disabled = false
	$ButtonSpawn.disabled = false
	for child in $VBoxStack.get_children():
		child.free()
	for child in $VBoxUsed.get_children():
		child.free()
	$Center/Label.text = ""


func make_used(Number):
	$VBoxStack.remove_child(Number)
	if Number:
		$Center/Label.text = Number.get_node("HBoxTop/Label").text
		$VBoxUsed.add_child(Number)


func _on_ButtonNormal_pressed():
	normal_array.shuffle()
	make_used(normal_array.pop_front())
	$ButtonNormal.disabled = normal_array.empty()


func _on_ButtonSpawn_pressed():
	spawn_array.shuffle()
	make_used(spawn_array.pop_front())
	$ButtonSpawn.disabled = spawn_array.empty()


func _on_ButtonReset_pressed():
	generate_numbers()


