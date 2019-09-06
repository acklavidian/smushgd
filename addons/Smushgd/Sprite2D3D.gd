extends Node2D
const Bone = Constants.Bone

export var IS_DEBUG_SKELETON_OVERLAY: bool = false
const LEFT_ARM = [Bone.LEFT_SHOULDER, Bone.LEFT_UPPERARM, Bone.LEFT_FOREARM, Bone.LEFT_HAND]
const RIGHT_ARM = [Bone.RIGHT_SHOULDER, Bone.RIGHT_UPPERARM, Bone.RIGHT_FOREARM, Bone.RIGHT_HAND]
const SPINE = [Bone.HEAD, Bone.TORSO, Bone.HIPS, Bone.LEFT_FOOT]

onready var CharacterViewport: Viewport = get_node('Viewport')
onready var CharacterAnimation: AnimationPlayer = CharacterViewport.get_node('Scene Root/AnimationPlayer')
onready var CharacterSkeleton: Skeleton = CharacterViewport.get_node('Scene Root/Armature/Skeleton')
onready var CharacterCamera: Camera = CharacterViewport.get_node('Camera')
onready var CharacterSprite: Sprite = get_node('Sprite')
#onready var CharacterBones: Dictionary = {
#    Bone.HEAD: CharacterSkeleton.get_node("HeadAttachment"),
#    Bone.HIPS: CharacterSkeleton.get_node('HipsAttachment'),
#    Bone.LEFT_FOOT: CharacterSkeleton.get_node('LeftFootAttachment'),
#    Bone.RIGHT_FOOT: CharacterSkeleton.get_node('RightFootAttachment'),
#    Bone.RIGHT_HAND: CharacterSkeleton.get_node('RightHandtAttachment'),
#    Bone.LEFT_HAND: CharacterSkeleton.get_node('LeftHandAttachment')
#}

onready var bone_positions: Array = []

func _process(delta):
    if IS_DEBUG_SKELETON_OVERLAY: 
        modulate = Color(1, 1, 1, 0.3)
        update()

func _draw():
    if (IS_DEBUG_SKELETON_OVERLAY):
        debug_skeleton_overlay()
        
func debug_skeleton_overlay():
    overlay_polyline(CharacterSkeleton.get_bone_count())
      
func overlay_circle(bone_id, color: Color = Color.red):
    var point = get_3Dbone_2Dcoord(bone_id)
    draw_circle(point, 3, color)
    
func overlay_polyline(bone_ids, color: Color = Color.red):
    var bone_poses = []
    for bone_id in bone_ids:
        var point = get_3Dbone_2Dcoord(bone_id)
        bone_poses.push_back(point)
    draw_polyline(bone_poses, color, 2)
    
func get_3Dbone_2Dcoord(bone_id: int):
    var global_origin = CharacterSkeleton.to_global(CharacterSkeleton.get_bone_global_pose(bone_id).origin)
    return CharacterCamera.unproject_position(global_origin)

func get_3Dbone_2Drotation(bone_id: int):
    var rotation = CharacterSkeleton.get_bone_global_pose(bone_id).basis.get_euler()
    return rotation.x * -1

func rotate_node2D_to_bone(node: Node2D, bone, offset: float = 0):
    var rot = get_3Dbone_2Drotation(bone) 
    node.rotation = rot + offset
    
func move_node2D_to_bone(node, bone, offset: Vector2 = Vector2.ZERO):
    node.position = get_3Dbone_2Dcoord(bone) + offset

    
    