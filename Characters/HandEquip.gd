@tool
extends Sprite2D

class_name HandEquip

@export var equipped_item : EquipableItem :
	set(next_equipped):
		equipped_item = next_equipped
		self.texture = next_equipped.texture
		
@export var sprite_2d : Sprite2D
@onready var area_2d : Area2D = $Area2D

func _ready():
	if(not Engine.is_editor_hint()):
		area_2d.monitoring = false

func _on_area_2d_body_entered(body):
	if(not Engine.is_editor_hint()):
		if(equipped_item.has_method("interact_with_body")):
			equipped_item.interact_with_body(body)
