extends Node2D

# Reference to the TileMap node
var tilemap: TileMap

# Shader material to change the greyscale property
var tile_shader: ShaderMaterial

func _ready():
	# Get the TileMap node
	tilemap = get_parent().get_node("TileMap")
	
	# Get the shader material from the TileMap
	tile_shader = tilemap.material as ShaderMaterial

# Called when the player enters the area (touches the tile)
func _on_body_entered(body):
	if body.name == "Player":  # Make sure it's the player that's touching the tile
		# Get the player's position in the tilemap's grid coordinates
		var player_grid_pos = tilemap.world_to_map(body.position)
		
		# Check if the player is on a valid tile (not empty)
		var tile_id = tilemap.get_cellv(player_grid_pos)
		
		if tile_id != -1:  # -1 means no tile is at that position
			# Disable greyscale by changing the shader uniform
			tile_shader.set_shader_param("is_greyscale", false)
