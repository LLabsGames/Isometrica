extends MarginContainer

@export var item_display_template : PackedScene

@onready var grid_container : GridContainer = $GridContainer

var displays : Array[ResourceItemDisplay]
var player_inventory : Inventory

func _ready():
	var player : Player = get_tree().get_first_node_in_group("player")
	player_inventory = player.find_child("Inventory") as Inventory
	player_inventory.connect("resource_count_changed", _on_player_inventory_resource_count_changed)
	
func _on_player_inventory_resource_count_changed(type : ResourceItem, new_count : int) -> void:
	# Find existing item display for type
	var current_display : ResourceItemDisplay
	
	# Find existing display and update the count if one is found
	for display in displays:
		if(display.resource_type == type):
			current_display = display
			current_display.update_count(new_count)
			break
	
	# If none exist, create a new one
	if(current_display == null):
		var new_display : ResourceItemDisplay = item_display_template.instantiate() as ResourceItemDisplay
		grid_container.add_child(new_display)
		new_display.resource_type = type
		new_display.update_count(new_count)
		displays.append(new_display)
