void printprintstack(colour c){
 for(int i = 0; i<printstack.size(); i++){
   Node n = (Node) printstack.pop();
   fill(c.r, c.g, c.b);
   rect(n.rec.x,n.rec.y, n.rec.w, n.rec.h);
   fill(0); 
  textAlign(CENTER, CENTER);
  textSize(textsize);
  text(n.val, n.rec.x+n.rec.w/2, n.rec.y+n.rec.h/2);
   
   printstack.addLast(n);
 }
}
