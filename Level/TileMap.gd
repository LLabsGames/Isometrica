extends TileMap

@export var mapSize: Vector2 = Vector2(50, 50)
@export var tileSize: Vector2 = Vector2(32, 32)
@export var wallThreshold: float = 0.45
@export var smoothingIterations: int = 5
@export var floorTileId: int = 0
@export var wallTileId: int = 2

var playerScene: PackedScene = preload("res://../Characters/player.tscn")

func _ready():
	generateTileMap()

func generateTileMap():
	randomize()
	clear()

	var initialMap: Array = generateInitialMap()
	var finalMap: Array = applyCellularAutomata(initialMap)

	for y in range(int(mapSize.y)):
		for x in range(int(mapSize.x)):
			var atlas: Vector2 = Vector2(2, 0)
			var tileId: int = floorTileId
			if finalMap[x][y]:
				set_cell(0, Vector2(x, y), tileId, atlas)
				set_cell(1, Vector2(x, y), tileId, atlas)
				set_cell(2, Vector2(x, y), tileId, atlas)
				set_cell(3, Vector2(x, y), wallTileId, atlas + Vector2(9, 0))
				set_cell(4, Vector2(x, y), wallTileId, atlas + Vector2(9, 0))
				set_cell(5, Vector2(x, y), wallTileId, atlas + Vector2(9, 0))
			else:
				set_cell(0, Vector2(x, y), tileId, atlas)

func generateInitialMap():
	var initialMap: Array = []
	for x in range(int(mapSize.x)):
		var row: Array = []
		for y in range(int(mapSize.y)):
			var isWall: bool = randf() < wallThreshold
			row.append(isWall)
		initialMap.append(row)
	return initialMap

func applyCellularAutomata(map: Array) -> Array:
	var finalMap: Array = map

	for __ in range(smoothingIterations):
		var newMap: Array = finalMap.duplicate()

		for x in range(1, int(mapSize.x) - 1):
			for y in range(1, int(mapSize.y) - 1):
				var wallCount: int = getSurroundingWallCount(finalMap, x, y)

				if wallCount > 4:
					newMap[x][y] = true
				elif wallCount < 4:
					newMap[x][y] = false

		finalMap = newMap

	return finalMap

func getSurroundingWallCount(map: Array, x: int, y: int) -> int:
	var wallCount: int = 0

	for i in range(-1, 2):
		for j in range(-1, 2):
			if i == 0 and j == 0:
				continue

			var checkX: int = x + i
			var checkY: int = y + j

			if checkX >= 0 && checkX < int(mapSize.x) && checkY >= 0 && checkY < int(mapSize.y):
				if map[checkX][checkY]:
					wallCount += 1

	return wallCount
