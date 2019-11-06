//ADD TO DRAW OR SETUP:
//T.traverseprint();

//ADD TO traverseprint(): 
//r_showtree(head);

float [] origin = {500, 50};
float [] size = {50, 50};
float spacing_x = 50;
float spacing_y = 60;
int counter = 0 ;
void r_showtree(Node cur) {
  draw_circle(cur);

  if (cur.right == null && cur.left == null) { // if leaf draw self and return
    return;
  }
  draw_line_bl();
  origin[0] -= spacing_x; //update origin to bottom left
  origin[1] += spacing_y;  

  r_showtree(cur.left); //go left and return from left

  origin[0] += 2*spacing_x; //update origin to the bottom right at the same spacing as it's own level


  r_showtree(cur.right); //go right and return from right
  // after going up fix spacing multiplier
  //fix spacing multiplier
  origin[1] -= spacing_y;// fix origin when going back from right
  origin[0] -= spacing_x;
  return;
}
void draw_circle(Node cur) {
  fill(100, 200, 50);
  ellipse(origin[0], origin[1], size[0], size[1]); //prints self
  fill(0x00000);
  textAlign(CENTER, CENTER);
  textSize(30);
  text(cur.val, origin[0], origin[1]);
}
void draw_line_br() {
  fill(0);
  line(origin[0], origin[1], origin[0]+spacing_x, origin[1]+spacing_y);
}
void draw_line_bl() {
  fill(0);
  line(origin[0]-size[0], origin[1]+size[1], origin[0]-spacing_x, origin[1]+spacing_y);
}
