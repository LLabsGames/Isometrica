extends Control


@onready var player : Player = get_tree().get_first_node_in_group("player")
var hand_equip : HandEquip

@onready var grid_container : GridContainer = $GridContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	if(player):
		hand_equip = player.find_child("HandEquip")
		
		for button in grid_container.get_children():
			if(button is ItemButton):
				button.hand_equip = hand_equip

