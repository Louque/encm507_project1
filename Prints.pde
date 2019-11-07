void printcurleft(Node cur) {
  fill(255, 255, 255); 
  if (cur.rec.x + cur.left.rec.w > costx) costx = cur.rec.x + cur.left.rec.w;
  if (cur.rec.y + cur.left.rec.h > costy) costy = cur.rec.y + cur.left.rec.h;

  rect(cur.rec.x+playarea_x, cur.rec.y+playarea_y, cur.left.rec.w, cur.left.rec.h);

  fill(0); 
  textAlign(CENTER, CENTER);
  textSize(textsize);
  text(cur.left.val, cur.rec.x+cur.left.rec.w/2+playarea_x, cur.rec.y+cur.left.rec.h/2+playarea_y);

  Node store = new Node(cur.left.val);
  store.rec = new rect_class(1, (int) (cur.rec.x+playarea_x), (int) (cur.rec.y+playarea_y), cur.left.rec.w, cur.left.rec.h);
  printstack.push(store);
}

void printcurright(Node cur) {
  fill(255, 255, 255);
  if (cur.rec.x + cur.right.rec.w > costx) costx = cur.rec.x + cur.right.rec.w;
  if (cur.rec.y + cur.right.rec.h > costy) costy = cur.rec.y + cur.right.rec.h;
  rect(cur.rec.x+playarea_x, cur.rec.y+playarea_y, cur.right.rec.w, cur.right.rec.h);

  fill(0); 
  textAlign(CENTER, CENTER);
  textSize(textsize);
  text(cur.right.val, cur.rec.x+cur.right.rec.w/2+playarea_x, cur.rec.y+cur.right.rec.h/2+playarea_y);

  Node store = new Node(cur.right.val);
  store.rec = new rect_class(1, (int) (cur.rec.x+playarea_x), (int) (cur.rec.y+playarea_y), cur.right.rec.w, cur.right.rec.h);
  printstack.push(store);
}

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

void reprintpolishafterchange() { // this is used to print result to the screen and refresh costs
  reprintflag = true; // this sets up the add function to keep the sizes from the last tree
  newtree.add(result.toCharArray()); //calls this with printstack set to true. Which now keeps sizes from last tree 
  //newtree.setsizesxy(1,2); // this is needed right now
  newtree.setsizesglobalrects(); //TODO change these to pull from a constant location? 
  
  printstack.clear();
  costx = costy =0; // need to reset the cost calcs everytime we make a new rect
  newtree.recursiverects(newtree.head);
}
