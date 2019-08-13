tool
extends Node2D
export var IS_DEBUG_SKELETON_OVERLAY: bool = false
export var resolution: Vector2 = Vector2(0,0)
var sprite2D3D
func _enter_tree():
    # Initialization of the plugin goes here
	sprite2D3D = preload('res://addons/Smushgd/Scenes/2D3DSprite.tscn').instance()
	sprite2D3D.IS_DEBUG_SKELETON_OVERLAY = IS_DEBUG_SKELETON_OVERLAY
	var viewport = sprite2D3D.get_node('Viewport')
	viewport.size = resolution
	
	inject3D()
	add_child(sprite2D3D)
	injectAttachments()

func inject3D():
	var viewport = sprite2D3D.get_node('Viewport')
	var children = get_children()
	for child in children:
		if child.get_class() == 'Spatial':
			viewport.add_child(child.duplicate())
			
func injectAttachments():
	var children = get_children()
	for child in children:
		if child.get('is_smushgd_attachment'):
			child.smushgd_node = sprite2D3D
			
func _exit_tree():
    # Clean-up of the plugin goes here
	remove_child(sprite2D3D)