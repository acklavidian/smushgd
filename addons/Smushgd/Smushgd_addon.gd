tool
extends EditorPlugin

func _enter_tree():
    # Initialization of the plugin goes here
    # Add the new type with a name, a parent type, a script and an icon
    add_custom_type("Smushgd", "Node2D", preload('res://addons/Smushgd/Smushgd_node.gd'), preload("res://addons/Smushgd/Icon2D3D.svg"))
    add_custom_type("Smushgd Attachment", "Node2D", preload('res://addons/Smushgd/Attachment2D3D.gd'), preload('res://addons/Smushgd/Icon2D3DAttachment.svg'))
func _exit_tree():
    # Clean-up of the plugin goes here
    # Always remember to remove it from the engine when deactivated
    remove_custom_type("Smushgd")
    remove_custom_type("Smushgd Attachment")