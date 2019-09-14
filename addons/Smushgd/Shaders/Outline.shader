shader_type canvas_item;
render_mode blend_mix;

uniform float outLineSize  = 0.02;
uniform vec4  outLineColor = vec4(1.0, 1.0, 1.0, 1.0);

void fragment()
{
    vec4 tcol = texture(TEXTURE, UV);
    
    if (tcol.a == 0.0)
    {
        if (texture(TEXTURE, UV + vec2(0.0,          outLineSize)).a  != 0.0 ||
            texture(TEXTURE, UV + vec2(0.0,         -outLineSize)).a  != 0.0 ||
            texture(TEXTURE, UV + vec2(outLineSize,  0.0)).a          != 0.0 ||
            texture(TEXTURE, UV + vec2(-outLineSize, 0.0)).a          != 0.0 ||
            texture(TEXTURE, UV + vec2(-outLineSize, outLineSize)).a  != 0.0 ||
            texture(TEXTURE, UV + vec2(-outLineSize, -outLineSize)).a != 0.0 ||
            texture(TEXTURE, UV + vec2(outLineSize,  outLineSize)).a  != 0.0 ||
            texture(TEXTURE, UV + vec2(outLineSize,  -outLineSize)).a != 0.0) 
            tcol = outLineColor;
    }
    
    COLOR = tcol;
}