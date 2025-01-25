shader_type canvas_item;
render_mode blend_premul_alpha;

// BORDE
uniform float aura_width = 2.0;
uniform vec4 aura_color : source_color;
uniform sampler2D noise_texture; // Textura de ruido
uniform float noise_scale = 10.0; // Escala del ruido
uniform float time; // Tiempo para animar el ruido

void fragment() {
    vec4 col = texture(TEXTURE, UV);
    vec2 ps = TEXTURE_PIXEL_SIZE;
    float a;
    float maxa = col.a;
    float mina = col.a;

    // Obtener ruido desplazado para animar
    vec2 noise_uv = UV * noise_scale + vec2(time * 0.2, time * 0.2);
    float noise_value = texture(noise_texture, noise_uv).r * 2.0 - 1.0;

    // Desplazar las muestras del borde con ruido
    vec2 offset = vec2(noise_value) * aura_width;

    a = texture(TEXTURE, UV + vec2(0.0, -aura_width) * ps + offset).a;
    maxa = max(a, maxa);
    mina = min(a, mina);

    a = texture(TEXTURE, UV + vec2(0.0, aura_width) * ps + offset).a;
    maxa = max(a, maxa);
    mina = min(a, mina);

    a = texture(TEXTURE, UV + vec2(-aura_width, 0.0) * ps + offset).a;
    maxa = max(a, maxa);
    mina = min(a, mina);

    a = texture(TEXTURE, UV + vec2(aura_width, 0.0) * ps + offset).a;
    maxa = max(a, maxa);
    mina = min(a, mina);

    col.rgb *= col.a;

    COLOR = col;
    COLOR.rgb += aura_color.rgb * (maxa - mina);
}
