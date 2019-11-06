void printcurleft(Node cur) {
  fill(random(1, 255), random(1, 255), random(1, 255)); 
  rect(cur.rec.x+playarea_x, cur.rec.y+playarea_y, cur.left.rec.w, cur.left.rec.h);
  fill(0); 
  textAlign(CENTER, CENTER);
  textSize(textsize);
  text(cur.left.val, cur.rec.x+cur.left.rec.w/2+playarea_x, cur.rec.y+cur.left.rec.h/2+playarea_y);
}

void printcurright(Node cur) {
  fill(random(100, 255), random(100, 255), random(100, 255)); 
  rect(cur.rec.x+playarea_x, cur.rec.y+playarea_y, cur.right.rec.w, cur.right.rec.h);
  fill(0); 
  textAlign(CENTER, CENTER);
  textSize(textsize);
  text(cur.right.val, cur.rec.x+cur.right.rec.w/2+playarea_x, cur.rec.y+cur.right.rec.h/2+playarea_y);
}
