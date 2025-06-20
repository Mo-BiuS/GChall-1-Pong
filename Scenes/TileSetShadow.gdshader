shader_type canvas_item;

uniform int[32*32] bitcodeMap;
uniform vec2 tileSize;
uniform float scale;
uniform float tcos;

void fragment() {
	ivec2 tilePos = ivec2(((FRAGCOORD.xy)/tileSize/scale)) ;
	int index = tilePos.x*32+tilePos.y;
	if (index >= 0 && index < 1024) {
		int code = bitcodeMap[index];
		if (code > 0) {
			float shadow = 0.0;
			vec2 lUv = fract(FRAGCOORD.xy / (tileSize * scale));
			
			if ((code & 1) != 0) shadow += (1.0 - lUv.x) * (1.0 - lUv.y);
			if ((code & 2) != 0) shadow += (lUv.x) * (1.0 - lUv.y);
			if ((code & 4) != 0) shadow += (lUv.x) * (lUv.y);
			if ((code & 8) != 0) shadow += (1.0 - lUv.x) * (lUv.y);
			
			vec4 tex_color = texture(TEXTURE, UV);
			tex_color.rgb *= 1.0 - shadow * 1.2 + tcos;
			COLOR = tex_color;
		}
	}
}