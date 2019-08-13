extends Node2D
export(Constants.Bone) var bone_index
var offsets: Array = []
const is_smushgd_attachment: bool = true

var smushgd_node: Node2D

func _ready():
    smushgd_node.connect('ready', self, 'update_attachments')

func _process(delta):
    var skeleton = smushgd_node.CharacterSkeleton
    for child_index in get_child_count():
        var child = get_child(child_index)
        var bone_coord = smushgd_node.move_node2D_to_bone(child, bone_index, offsets[child_index])
        
func update_attachments():
    for child_index in get_child_count():
        var child = get_child(child_index)
        var bone_pos = smushgd_node.get_3Dbone_2Dcoord(bone_index)
        offsets.push_back(child.position - bone_pos)