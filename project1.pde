///ENCM 507 Fall 2019 //<>//
/// Luke Renaud and Robert Krivelis
///
///
import java.util.ArrayDeque;

String s = "12H534VHV"; //MUST be a valid polish expresion THIS IS THE CURRENT USER INPUT, update with better way later.
int scalingvariable = 20; //ROBERT's favorite variable.H34VH
int textsize = 15;
char[] polish;
int sizeModifier = 50; // make this the WORST case scenario of playarea_w / (width of all boxes) which is the case with all vertical cuts OR worst case of all boxes vertically stackeda and playarea_h
float playarea_x = (1920/2)/4;
float playarea_y = (1080/2)/4;
float playarea_w = (1920/2)/2;
float playarea_h = (1080/2)/2;

Tree  T;
Tree newtree; //duhhhh can't just clone trees without writing a clone function. gah


//**********Setup************
void setup() {
  size(960, 540);
  background(255);
  T = new Tree(); //the giving tree
  T.add(s.toCharArray()); //call function to add the polish expression into the Tree T
  T.traverseprint(); //testing this to show it makes the tree correctly

  fill(230, 230, 220);
  rect(playarea_x, playarea_y, playarea_w, playarea_h); //creates play area. playarea_variables will be used as part of placement as well.

  newtree = new Tree(); //hacky way of doing this in order to make sure it is displaying correctly
  newtree.add(s.toCharArray());
  newtree.setsizesrandom();
  newtree.recursiverects(newtree.head);

  //should really make get functions for the Tree class to ensure bad things can't happen to the data from user functions
}
//**********Draw************
void draw() { //repeat infinitum

  //populate play area based on polish expression. Easier to do all operations on.
  //drawcurrentpolish(playarea_x, playarea_y); //this uses what's in newtree, but could be made to

  //have origin x and y which is handed into the function to allow function to know where to print
  //been looking at this paper to help implement laying out using the stack: http://cc.ee.ntu.edu.tw/~ywchang/Courses/PD_Source/EDA_floorplanning.pdf
  //newtree.reloadtreetostack();
  //ArrayDeque tempque = newtree.polish.clone(); //update from newtree each time
  //int i = 0; //colour modifier
  //newtree.stack.clear(); // not sure why we are using the tree stack, but that's just the way she goes right now

  //maybe I just REALLY Want to recursively print these out. Stack is not seeing intuitive right now.
  //while(!tempque.isEmpty()){
  //  Node tempnode = (Node) tempque.pop();
  //  if(tempnode.val != 'V' && tempnode.val != 'H'){ //if it's not a cut, print the box out
  //    tempnode.right = (Node) newtree.stack.pop();
  //    tempnode.left = (Node) newtree.stack.pop();
  //    fill(200+i*5,100+i*5,0); //orange//this breaks with more than 10 nodes. fix before then
  //    rect(tempnode.rec.x+playarea_x, tempnode.rec.y+playarea_y, tempnode.rec.w, tempnode.rec.h); //this is just to show it can print the rects.
  //  }
  //  else{// I am a leaf node, push me
  //    newtree.stack.push(tempnode);
  //  }
  //}
  //recursive way: deciding not to use right now


  //maybe drawing is best done recursively from top of tree.
}





//**********Classes************

public class rect_class { // class for each rectangle
  public int id; //not sure if we are going to use this
  public int x; // starting x
  public int y; // starting y
  public int w; // width
  public int h; // height

  rect_class (int id0, int x0, int y0, int w0, int h0) {//constructor for rext_class
    id = id0;
    x = x0; // starting x
    y = y0; // starting y
    w = w0; // width
    h = h0; // height
  }
}

public class Node { // these are the tree nodes for the polish expression
  public char val; // maybe should just make this the ID?
  public Node left; // left child
  public Node right; // right child
  public rect_class rec;

  Node (char V) {
    val = V;
    left = null; // left child
    right = null; // right child
    rec = null;
  }
}

//TODO: Add functionality that allows each H/V cut to have size of all objects below it.

public class Tree { // these are the tree nodes for the polish expression
  public Node head;
  ArrayDeque stack;
  ArrayDeque polish;

  Tree () {
    head = null;
    stack = new ArrayDeque();
    polish = new ArrayDeque();
  }
  void add (char[] a) {
    stack.clear();
    for (int i = 0; i < a.length; i++) { //for each item in the polish expression check

      if (a[i] == 'V' || a[i] == 'H') { //if it's a cut, pop the previous 2
        Node current = new Node(a[i]);
        current.right = (Node) stack.pop();
        current.left = (Node) stack.pop();
        if (i == a.length-1) { // this is the last node and we don't want to push this, but rather set it to head
          head = current;
          return;
        }
        stack.push(current);
      } else {
        stack.push(new Node(a[i])); //if not a cut then a number, so push it into the stack.
      }
    }
  }

  void reloadtreetostack() {
    stack.clear();
    recursive(head);
    polish = stack; //stack and polish will have same tree after this
  }

  void setsizesrandom() {
    stack.clear();
    recursive(head);
    while (!stack.isEmpty()) {
      Node tempnode = (Node) stack.pop();
      if (tempnode.val != 'V' && tempnode.val != 'H') { //only add dimensions to non-cut nodes for now. Node sizes will be based on children and calcuated later
        tempnode.rec =  new rect_class(1, 0, 0, (int) random(1, 4)*scalingvariable, (int) random(1, 4)*scalingvariable);
        //tempnode.rec =  new rect_class(1, 0, 0, 1*scalingvariable, 2*scalingvariable);
      } else {
        tempnode.rec =  new rect_class(1, 0, 0, 0, 0);
      }
      polish.addLast(tempnode); // so polish should be filled with the correct stack now
    }
  }

  void traverseprint() { //really easy to copy for other functionality using stack (which is the polish expression)
    stack.clear();
    recursive(head);

    while (!stack.isEmpty()) {//until the stack is empty, print the value from the top down
      Node temp = (Node) stack.pop();
      print(temp.val);
      polish.addLast(temp);
    }
    stack = polish;
  }

  void recursive(Node cur) { //this recursively pushed items from head into the stack (to be printed later)
    stack.push(cur);
    if (cur.right == null && cur.left == null) { //this is the base case for returning from leaf nodes
      return;
    }
    recursive(cur.right);
    recursive(cur.left);
    return;
  }

  void recursiverects(Node cur) {
    fill(100, 230, 0);
    println("I am in cur.val of", cur.val);  
    if (cur.right == null && cur.left == null) { //this is the base case for returning from leaf nodes
      return;
    }


    if (cur.left.val == 'V' || cur.left.val == 'H') { //if we are going to the left down to a cut
      if (cur.val == 'V') { //if we are in a vertical cut, shift origin right
        cur.left.rec = cur.rec;
      } else if (cur.val == 'H') { //if we are in a horizontal cut, shift origin down
        cur.left.rec = cur.rec;
      }
    }
    recursiverects(cur.left); // **************************************************LEFT
    if (cur.left.val != 'V' && cur.left.val != 'H') {  //****************************LEFT LEAF
      if (cur.val == 'V') { //we have a vertical cut, to stack the value just returned from at the base location of the V cut position (cut.rec. is this)
        printcurleft(cur);

        cur.rec.x += cur.left.rec.w;
        cur.rec.h = cur.left.rec.h;
      } else if (cur.val == 'H') {// horizontal cut, but the left one so we still place in the same spot
        printcurleft(cur);

        cur.rec.y += cur.left.rec.h;
        cur.rec.w = cur.left.rec.w;
      }
      //need to update the size of the cut node's dimensions for using in other levels.
    } else {  // LEFT CUT
      if (cur.left.val == 'H' && cur.val == 'V') { //if cut shift origin based on last block placed  H->V and V->H are the only ones that need origin moving.
        cur.rec.x += cur.left.rec.w; //just changed to +=
        cur.rec.y -= cur.left.rec.h;
        cur.rec.w = cur.left.rec.w;
        cur.rec.h = cur.left.rec.h;
      } else if (cur.left.val == 'V' && cur.val == 'H') {
        cur.rec.x -= cur.left.rec.w;
        cur.rec.y += cur.left.rec.h;//just changed to +=
        cur.rec.w = cur.left.rec.w;
        cur.rec.h = cur.left.rec.h;
      } else {
        cur.rec.x = cur.left.rec.x;
        cur.rec.y = cur.left.rec.y;
        cur.rec.w = cur.left.rec.w;
        cur.rec.h = cur.left.rec.h;
      }
    }


    if (cur.right.val == 'V' || cur.right.val == 'H') { //if we are going to the right down to a cut
      if (cur.val == 'V') { //if we are in a vertical cut, shift origin right
        cur.right.rec = cur.rec;
      } else if (cur.val == 'H') { //if we are in a horizontal cut, shift origin down
        cur.right.rec = cur.rec;
      }
    }
    recursiverects(cur.right); // RIGHT
    if (cur.right.val != 'V' && cur.right.val != 'H') {  //RIGHT LEAF
      if (cur.val == 'V') { //we have a vertical cut, to stack the value just returned from at the base location of the V cut position (cut.rec. is this)
        printcurright(cur);

        cur.rec.x += cur.right.rec.w;
        cur.rec.w = cur.right.rec.w + cur.left.rec.w;
        if (cur.rec.h < cur.right.rec.h) cur.rec.h = cur.right.rec.h; // choose largest height
      } else if (cur.val == 'H') {// horizontal cut, but the left would have already shifted the current positional value after it ran
        printcurright(cur);

        cur.rec.y += cur.right.rec.h;
        cur.rec.h = cur.right.rec.h + cur.left.rec.h;
        if (cur.rec.w < cur.right.rec.w) cur.rec.w = cur.right.rec.w; // choose largest width.
      }
    } else {// RIGHT CUT
      if (cur.right.val == 'H' && cur.val == 'V') { //if cut shift origin based on last block placed  H->V and V->H are the only ones that need origin moving.
        cur.rec.x += cur.right.rec.w;
        if (cur.rec.h < cur.right.rec.h) cur.rec.h = cur.right.rec.h; // choose largest height
      } else if (cur.right.val == 'V' && cur.val == 'H') {
        cur.rec.y += cur.right.rec.h;
        if (cur.rec.w < cur.right.rec.w) cur.rec.w = cur.right.rec.w; // choose largest width.
      } else {
        cur.rec.x = cur.right.rec.x;
        cur.rec.y = cur.right.rec.y;
      }
    }
    return;
  }
}  

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
//TODO perform placement and calculate cost during.
//TODO Implement simulated annealing
//TODO use stack to implement move functions
