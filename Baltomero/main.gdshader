shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float scanline_count : hint_range(0, 1800) = 50.0;

void fragment()
{
    // Accedemos al color de la textura de la pantalla sin distorsión.
    float r = texture(SCREEN_TEXTURE, SCREEN_UV).r;
    float g = texture(SCREEN_TEXTURE, SCREEN_UV).g;
    float b = texture(SCREEN_TEXTURE, SCREEN_UV).b;
    
    // Aplicamos el efecto de scanlines
    float s = sin(SCREEN_UV.y * scanline_count * PI * 8.0);
    s = (s * 0.5 + 0.5) * 0.9 + 0.1;
    vec4 scan_line = vec4(vec3(pow(s, 0.15)), 1.0);
    
    // Combinamos el color extraído con el efecto de scanlines.
    COLOR = vec4(r, g, b, 1.0) * scan_line;
}