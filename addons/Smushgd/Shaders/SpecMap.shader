shader_type canvas_item;

uniform float thresh : hint_range(0,1) = 0.5;
uniform float contrast : hint_range(0,4) = 1;
uniform float bright : hint_range(-1,1) = 0;
uniform int blur : hint_range(0,10) = 5;
uniform bool invert = false;

vec4 gray_scale(sampler2D TEXTURE, vec2 texCoord){
	vec4  FragColor = texture(TEXTURE, texCoord);
    float average = (FragColor.r +FragColor.g +FragColor.b)/3.0;
    return vec4(vec3(average), 1.0);
}

vec4 borders(sampler2D TEXTURE, vec2 texCoord){
	if(texCoord.x > 1.0 || texCoord.y > 1.0 || texCoord.x < 0.0 || texCoord.y < 0.0)
		return vec4(0.0);
	return vec4(vec3(float(texture(TEXTURE, texCoord).a != 0.0)),1.0);
}

void fragment() {
	float alfa = texture(TEXTURE,UV).a;
	vec2 offset = TEXTURE_PIXEL_SIZE;
	float color = 0.0;
	for(int i =- blur; i<= blur; i++){
		for (int j= -blur; j <= blur; j++){
			color += contrast*(gray_scale(TEXTURE,UV+vec2(float(i)*offset.x,float(j)*offset.y)).r-thresh)+thresh+bright;
		}
	}
	color /= pow(2.0*float(blur)+1.0,2.0);
	if (invert) color = 1.0-color;
	COLOR = vec4(vec3(color),alfa);
}