//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPos;

uniform vec3 u_vLight;
uniform vec3 u_vDark;
uniform float u_fFadeDist;
uniform float u_fTexSize;
uniform float u_fTime;

void main(){
    gl_FragColor = vec4(mix(u_vDark,u_vLight,max(0.,1.-v_vPos.x/u_fFadeDist)),texture2D( gm_BaseTexture, v_vTexcoord + vec2(min(1.,v_vPos.x/u_fFadeDist*2.)*u_fTexSize*sin(u_fTime+v_vPos.x/3.+v_vPos.y/3.),0.)).a);
}