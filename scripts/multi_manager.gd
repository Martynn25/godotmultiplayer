extends Node
var hole_puncher
const SERVER_PORT = 8910
const SERVER_IP = "10.0.0.1"
var player_id = OS.get_unique_id()
var is_host = true
const MAX_CLIENTS = 2

var game_code
var player_info_name
var player_info_id
func _process(_delta: float):
	multiplayer.poll()
func _ready():
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
func connection_failed():
	print("connection failed")
func connected_to_server():
	print("connected to server")
func peer_disconnected():
	print("peer disconnected")
func peer_connected():
	print("peer connected")
func joined_some1():
	var peer_join = ENetMultiplayerPeer.new()
	peer_join.create_client(SERVER_IP, SERVER_PORT,2)
	peer_join.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer_join)
	player_info_id = multiplayer.get_unique_id()
	_add_player_to_game(player_id)
func become_host():
	var peer_host = ENetMultiplayerPeer.new()
	peer_host.create_server(SERVER_PORT, MAX_CLIENTS,2)
	peer_host.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer_host)
	player_info_id = multiplayer.get_unique_id()
	if multiplayer.is_server():
		print("IM DA SERVER")
	_add_player_to_game("1")
func _add_player_to_game(id: String):
	print("player %s joined the game " % id)
func _del_player(id: String):
	print("player %s left the game " % id)
@rpc
func print_once_per_client():
	print("I will be printed to the console once per each connected client.")
