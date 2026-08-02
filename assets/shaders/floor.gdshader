shader_type canvas_item;

uniform vec4 target_color : source_color = vec4(0.165, 0.165, 0.176, 1.0); // Color to mask/replace
uniform float tolerance : hint_range(0.0, 1.0) = 0.1;              // How close the color must match
uniform sampler2D replacement_tex : repeat_enable, filter_nearest;

uniform float scale = 0.1;
varying vec2 world_position;

void vertex() {
	world_position = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {
    vec4 current_color = texture(TEXTURE, UV);
    
    // Find the distance between the pixel color and the target color
    float current_distance = distance(current_color.rgb, target_color.rgb);
    
    if (current_distance < tolerance) {
        COLOR = texture(replacement_tex, world_position * scale);
    	//COLOR.rgb /= 2.0;
	} else {
        COLOR = current_color;
    }
}