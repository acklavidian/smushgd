class_name Attachment2D3D extends Node2D
export(Constants.Bone) var bone_index
var offsets: Array = []

func _ready():
    get_parent().connect('ready', self, 'update_attachments')

func _process(delta):
    var skeleton = get_parent().CharacterSkeleton
    for child_index in get_child_count():
        var child = get_child(child_index)
        var bone_coord = get_parent().move_node2D_to_bone(child, bone_index, offsets[child_index])
        
func update_attachments():
    for child_index in get_child_count():
        var child = get_child(child_index)
        var bone_pos = get_parent().get_3Dbone_2Dcoord(bone_index)
        offsets.push_back(child.position - bone_pos)