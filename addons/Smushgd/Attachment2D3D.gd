extends Node2D
export(Constants.Bone) var bone_index
export(bool) var use_rotation = false 
export(bool) var use_rot_offset = false
export(bool) var use_pos_offset = false
const is_smushgd_attachment: bool = true
var pos_offsets: Array = []
var rot_offsets: Array = []
onready var smushgd_node: Node2D = get_node('../Smushgd Node') if smushgd_node == null else smushgd_node
onready var animation_player: AnimationPlayer = smushgd_node.get_node('Viewport/Scene Root/AnimationPlayer')

func _ready():
    smushgd_node.connect('ready', self, 'update_attachments')
    animation_player.connect('animation_started', self, 'update_attachments')

func _process(delta):
    var skeleton = smushgd_node.CharacterSkeleton
    for child_index in get_child_count():
        var child: Node2D = get_child(child_index)
        var bone_coord = smushgd_node.move_node2D_to_bone(child, bone_index, pos_offsets[child_index] if use_pos_offset else Vector2.ZERO)
        if use_rotation: smushgd_node.rotate_node2D_to_bone(child, bone_index, rot_offsets[child_index] if use_rot_offset else 0)
        
func update_attachments():
    for child in get_children():
        var bone_pos = smushgd_node.get_3Dbone_2Dcoord(bone_index)
        var bone_rot = smushgd_node.get_3Dbone_2Drotation(bone_index)
        pos_offsets.push_back(child.position - bone_pos)
        rot_offsets.push_back(child.rotation)