shader_type canvas_item;
render_mode blend_premul_alpha;

// BORDE
uniform float progress;
uniform float time;
uniform float aura_width = 2.0;
uniform vec4 aura_color : source_color;

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	vec2 ps = TEXTURE_PIXEL_SIZE;
	float a;
	float maxa = col.a;
	float mina = col.a;

	a = texture(TEXTURE, UV + vec2(0.0, -aura_width*(progress*sin(UV.y*15.+time))) * ps).a;
	maxa = max(a, maxa);
	mina = min(a, mina);

	a = texture(TEXTURE, UV + vec2(0.0, aura_width*(progress*cos(UV.y*20.+time))) * ps).a;
	maxa = max(a, maxa);
	mina = min(a, mina);

	a = texture(TEXTURE, UV + vec2(-aura_width*(progress*cos(UV.x*60.+time)), 0.0) * ps).a;
	maxa = max(a, maxa);
	mina = min(a, mina);

	a = texture(TEXTURE, UV + vec2(aura_width*(progress*sin(UV.x*30.+time)), 0.0) * ps).a;
	maxa = max(a, maxa);
	mina = min(a, mina);

	col.rgb *= col.a;

	COLOR = col;
	COLOR.rgb += aura_color.rgb * (maxa - mina);
}