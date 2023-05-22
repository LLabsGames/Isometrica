extends Node

class_name Inventory

@export var resources : Dictionary = { }

signal resource_count_changed(type : ResourceItem, new_count : int)

func add_resources(type : ResourceItem, amount : int):
	if(resources.has(type)):
		resources[type] = resources[type] + amount
	else:
		resources[type] = amount
		
	emit_signal("resource_count_changed", type, resources[type])
