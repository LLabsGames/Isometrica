extends Node

# Load your TileSets
var tilesets = {
	"floor": preload("res://Tilesets/MinecraftFloors.tres"),
	"goods": preload("res://Tilesets/MinecraftGoods.tres"),
	"items": preload("res://Tilesets/MinecraftItems.tres"),
	"leaves": preload("res://Tilesets/MinecraftLeaves.tres"),
	"liquids": preload("res://Tilesets/MinecraftLiquids.tres"),
	"plants": preload("res://Tilesets/MinecraftPlants.tres"),
	"rocks": preload("res://Tilesets/MinecraftRocks.tres"),
	"woods": preload("res://Tilesets/MinecraftWoods.tres"),
	"general": preload("res://Tilesets/MinecraftBlocks.tres"),
}

# Define ids and atlas coordinates of your tiles here.
var tile_ids = {
	"floor": [1,   Vector2( 2,  0)],
	"almaz": [1, Vector2(16,  2)],
	"coal":  [1,   Vector2(13,  2)],
	"iron":  [1,   Vector2(14,  2)],
	"items": [1,   Vector2( 7, 18)],
	"leaves": [1,  Vector2(12,  4)],
	"liquids": [1, Vector2(10,  3)],
	"plants": [1,  Vector2( 6,  4)],
	"rocks": [1,   Vector2(11,  0)],
	"woods": [1,   Vector2( 1,  5)],
	"snow": [1,    Vector2( 5,  0)],
}

var tilemaps = []  # Store tilemap instances in an array
#var tree_params = {
#	"trunk_height_min": 3,
#	"trunk_height_max": 6,
#	"leaf_size_min": 2,
#	"leaf_size_max": 3,
#}

func _ready():
	generate_world(Vector2i(40, 40))
	
func generate_world(world_size):
	const cube_size: int = 50
	const set_name: String = "general"
	var ranges = range(-(cube_size/2), (cube_size/2))
	var tileset: TileSet = tilesets[set_name]
	tileset.tile_shape = TileSet.TILE_SHAPE_ISOMETRIC
	tileset.tile_size = Vector2(24,12)
	tileset.tile_layout = TileSet.TILE_LAYOUT_DIAMOND_DOWN
	
	for index in ranges:
		var tilemap = TileMap.new()
		tilemap.set_tileset(tileset)
		tilemap.name = "TileMap, Z: " + str(index)
		tilemap.z_index = index
		self.add_child(tilemap)
		tilemaps.append(tilemap)

	for z in ranges:
		for x in range(ranges.min() - z, ranges.max() - z):
			for y in range(ranges.min() - z, ranges.max() - z):

				if z < 0:
					if randf_range(1,100) < 1.5:
						tilemaps[z + cube_size / 2].set_cell(0, Vector2(x, y), 0, tile_ids["almaz"][1])
					elif randi_range(1,100) < 3:
						tilemaps[z + cube_size / 2].set_cell(0, Vector2(x, y), 0, tile_ids["iron"][1])
					elif randi_range(1,100) < 4:
						tilemaps[z + cube_size / 2].set_cell(0, Vector2(x, y), 0, tile_ids["coal"][1])
					else:
						tilemaps[z + cube_size / 2].set_cell(0, Vector2(x, y), 0, tile_ids["rocks"][1])
				elif z == 0:
					tilemaps[z + cube_size / 2].set_cell(0, Vector2(x, y), 0, tile_ids["floor"][1])
				elif z == 1:
					if randi_range(1,100) < 3:
						tilemaps[z + cube_size / 2].set_cell(0, Vector2(x, y), 0, tile_ids["items"][1])
				

	








	#for layer_type in tilesets.keys():
	#	var tilemap = TileMap.new()
	#	tilemap.set_tileset(tilesets[layer_type])
	#	self.add_child(tilemap)
	#	tilemaps.append(tilemap)  # Add each tilemap to the array

	#for i in range(0,(len(tilemaps)-1)):
	#	var  tilemap   = tilemaps[i]
	#	var layer_type = tilesets.keys()[i]
	#	for y in range(world_size.y):
	#		for x in range(world_size.x):
	#			var height = int((noise.get_noise_2d(x / 10.0, y / 10.0) + 1) / 2 * world_size.y)
	#			for z in range(height):
	#				tilemap.set_cell(0, Vector2(x, y - z), 0, tile_ids[layer_type][1])

	#	for y in range(world_size.y):
	#		for x in range(world_size.x):
	#			var height = int((noise.get_noise_2d(x / 10.0, y / 10.0) + 1) / 2 * world_size.y)
	#			if randf() < 0.1 and height < len(tilemaps):
	#				tilemaps[height].set_cell(0, Vector2(x, y), 0, tile_ids["plants"][1])
	#			elif randf() < 0.01 and height < len(tilemaps):
	#				tilemaps[height].set_cell(0, Vector2(x, y), 0, tile_ids["items"][1])

	#for _i in range(10):
	#	var tree_pos = Vector2(randi() % world_size.x, randi() % world_size.y)
	#	generate_tree(tree_pos, len(tilemaps) - 1)

	#for _i in range(2):
	#	var hill_pos = Vector2(randi() % world_size.x, randi() % world_size.y)
	#	var hill_size = Vector2(randi() % 5 + 5, randi() % 5 + 5)
	#	var hill_height = randi() % 8 + 3
	#	generate_hill(hill_pos, hill_size, hill_height)

#func generate_tree(position, layer):
	#var trunk_height = randf_range(tree_params["trunk_height_min"], tree_params["trunk_height_max"] + 1)
	#var leaf_size = randf_range(tree_params["leaf_size_min"], tree_params["leaf_size_max"] + 1)
	
	# generate trunk
	#for i in range(trunk_height):
	#	tilemaps[layer].set_cell(0, position + Vector2(0, -i), 0, tile_ids["woods"][1])

	# generate leaves
	#var leaf_positions = get_positions_in_sphere(leaf_size)
	#for leaf_position in leaf_positions:
	#	var world_position = position + leaf_position + Vector2(0, -trunk_height)
	#	if valid_position(world_position, layer):
	#		tilemaps[layer].set_cell(0, world_position, 0, tile_ids["leaves"][1])

func generate_hill(position, size, height):
	for z in range(height):
		for y in range(-size.y / 2, size.y / 2 + 1):
			for x in range(-size.x / 2, size.x / 2 + 1):
				var hill_pos = position + Vector2(x, y)
				tilemaps[z].set_cell(0, hill_pos, 0, tile_ids["rocks"][1])
		
		if z == height - 1:  # cover the top with snow
			for y in range(-size.y / 2, size.y / 2 + 1):
				for x in range(-size.x / 2, size.x / 2 + 1):
					var hill_pos = position + Vector2(x, y)
					tilemaps[z].set_cell(0, hill_pos, 0, tile_ids["snow"][1])

func get_positions_in_sphere(radius):
	var positions = []
	for z in range(-radius, radius + 1):
		for y in range(-radius, radius + 1):
			for x in range(-radius, radius + 1):
				var distance = Vector3(x, y, z).length()  # Get the distance from the center
				if distance <= radius:  # Only add positions that are within the radius
					positions.append(Vector2(x, y))
	return positions

func valid_position(position, layer):
	if position.x < 0 or position.y < 0:
		return false
	if layer < 0 or layer >= len(tilemaps):
		return false
	return true
