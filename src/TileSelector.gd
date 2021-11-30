extends Control

const Number_load = preload("res://src/Number.tscn")
const spawn_numbers = [7,9,11,16,17]

export(Color) var color_spawn
export(Color) var color_normal

var spawn_array = []
var normal_array = []

func _ready():
	randomize()
	spawn_numbers()


func spawn_numbers():
	clear_UI()
	spawn_array = []
	normal_array = []
	for number in range(1,22):
		var Number = Number_load.instance()
		Number.get_node("Label").text = str(number)
		Number.get_node("BG").color = color_normal
		if number in spawn_numbers:
			Number.get_node("BG").color = color_spawn
			spawn_array.append(Number)
		else:
			normal_array.append(Number)
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
	$Center/Label.text = Number.get_node("Label").text
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
	spawn_numbers()


