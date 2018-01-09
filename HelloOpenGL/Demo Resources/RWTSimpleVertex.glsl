attribute vec4 a_Position;
attribute vec4 a_Color;

varying lowp vec4 frag_color;

void main(void) {
  gl_Position = a_Position;
  frag_color = a_Color;
}
