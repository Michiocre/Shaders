void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord / iResolution.xy;
    // Shift pixel coordinates so 0 is center
    
    uv -= 0.5;

    // Time varying pixel color
    vec3 col = vec3(0.0, 0.0, 0.0);

    float circle = step(length(uv), sin(uv.x * (sin(iGlobalTime) * 100.0)) * 0.3);

    col = vec3(circle);
    

    // Output to screen
    fragColor = vec4(col, 1.0);
}