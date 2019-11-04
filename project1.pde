///ENCM 507 Fall 2019
/// Luke Renaud and Robert Krivelis
///
///
import java.util.ArrayDeque;

String s = "12H34H5HV"; //MUST be a valid polish expresion THIS IS THE CURRENT USER INPUT, update with

char[] polish;
int sizeModifier = 50; // make this the WORST case scenario of playarea_w / (width of all boxes) which is the case with all vertical cuts OR worst case of all boxes vertically stackeda and playarea_h
float playarea_x = (1920/2)/4;
float playarea_y = (1080/2)/4;
float playarea_w = (1920/2)/2;
float playarea_h = (1080/2)/2;

Tree  T;
Tree newtree; //duhhhh can't just clone trees without writing a clone function. gah


//**********Setup************
void setup(){
  size(960, 540);
 
  T = new Tree(); //the giving tree
  T.add(s.toCharArray()); //call function to add the polish expression into the Tree T
  T.traverseprint(); //testing this to show it makes the tree correctly
 
  newtree = new Tree(); //hacky way of doing this in order to make sure it is displaying correctly
  newtree.add(s.toCharArray());
  newtree.setsizesrandom();
    //should really make get functions for the Tree class to ensure bad things can't happen to the data from user functions
}
//**********Draw************
void draw(){ //repeat infinitum
  background(255);
  fill(230, 230, 220);
  rect(playarea_x, playarea_y, playarea_w, playarea_h); //creates play area. playarea_variables will be used as part of placement as well.

  //populate play area based on polish expression. Easier to do all operations on.
  drawcurrentpolish(playarea_x, playarea_y); //this uses what's in newtree, but could be made to

}
//have origin x and y which is handed into the function to allow function to know where to print
void drawcurrentpolish(float originx, float originy){ //easiest way to to recursively print from
//been looking at this paper to help implement laying out using the stack: http://cc.ee.ntu.edu.tw/~ywchang/Courses/PD_Source/EDA_floorplanning.pdf
  newtree.reloadtreetostack();
  ArrayDeque tempque = newtree.polish.clone(); //update from newtree each time
  int i = 0; //colour modifier
  newtree.stack.clear(); // not sure why we are using the tree stack, but that's just the way she goes right now
 
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
  recursiverects(newtree.head);
 
//maybe drawing is best done recursively from top of tree.
}

void recursiverects(Node cur){
      if(cur.right == null && cur.left == null){ //this is the base case for returning from leaf nodes
        return;
      }
      //every time we go a level deep we WANT the positional data. ?? do we?
      recursiverects(cur.left); // this recursive function goes from left to right// every time it comes back from a left, it's going to print all nodes in position.
      if(cur.left.val != 'V' && cur.left.val != 'H'){  //making sure we aren't returning from a cut.
        if(cur.val == 'V'){
          rect(cur.rec.x+playarea_x, cur.rec.y+playarea_y, cur.left.rec.w, cur.left.rec.h);
        }
        else if(cur.val == 'H'){
          rect(cur.rec.x+playarea_x, cur.rec.y+playarea_y, cur.left.rec.w, cur.left.rec.h);
        }
      }  
      else{//means returning from a cut
         if(cur.val == 'V'){
           rect(cur.left.rec.x+playarea_x, cur.left.rec.y+playarea_y, cur.left.rec.w, cur.left.rec.h);
         }
         else if(cur.val == 'H'){
           rect(cur.left.rec.x+playarea_x, cur.left.rec.y+playarea_y, cur.left.rec.w, cur.left.rec.h);
         }
      }
     
      recursiverects(cur.right);
      if(cur.val == 'V' && cur.right.val != 'V' && cur.right.val != 'H'){
      rect(cur.right.rec.x+playarea_x+cur.left.rec.w, cur.right.rec.y+playarea_y, cur.right.rec.w, cur.right.rec.h);
      }
      else if(cur.val == 'H' && cur.right.val != 'V' && cur.right.val != 'H'){
      rect(cur.right.rec.x+playarea_x, cur.right.rec.y+playarea_y + cur.left.rec.h, cur.right.rec.w, cur.right.rec.h);
      }
      else{//means returning from a cut
      }
      //make a rectangle every time we return from two functions. // only happens with cuts.
     

      return;
}



//**********Classes************

public class rect_class { // class for each rectangle
    public int id; //not sure if we are going to use this
    public int x; // starting x
    public int y; // starting y
    public int w; // width
    public int h; // height

  rect_class (int id0, int x0, int y0, int w0, int h0){//constructor for rext_class
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
   
    Node (char V){
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
   
    Tree (){
      head = null;
      stack = new ArrayDeque();
      polish = new ArrayDeque();
    }
    void add (char[] a){
      stack.clear();
      for(int i = 0; i < a.length; i++){ //for each item in the polish expression check

         if(a[i] == 'V' || a[i] == 'H'){ //if it's a cut, pop the previous 2
            Node current = new Node(a[i]);
            current.right = (Node) stack.pop();
            current.left = (Node) stack.pop();
            if(i == a.length-1){ // this is the last node and we don't want to push this, but rather set it to head
              head = current;
              return;
            }
            stack.push(current);
          }
        else{
          stack.push(new Node(a[i])); //if not a cut then a number, so push it into the stack.
        }
      }
    }
   
    void reloadtreetostack(){
            stack.clear();
            recursive(head);
            polish = stack; //stack and polish will have same tree after this
    }
   
    void setsizesrandom(){
            stack.clear();
            recursive(head);
            while(!stack.isEmpty()){
              Node tempnode = (Node) stack.pop();
              if(tempnode.val != 'V' && tempnode.val != 'H'){ //only add dimensions to non-cut nodes for now. Node sizes will be based on children and calcuated later
                tempnode.rec =  new rect_class(1,0,0, (int) random(1,4)*50, (int) random(1,4)*50);
              }
              polish.addLast(tempnode); // so polish should be filled with the correct stack now
            }

    }
   
    void traverseprint(){ //really easy to copy for other functionality using stack (which is the polish expression)
      stack.clear();
      recursive(head);
     
      while(!stack.isEmpty()){//until the stack is empty, print the value from the top down
        Node temp = (Node) stack.pop();
        print(temp.val);
        polish.addLast(temp);
      }
      stack = polish;
    }

    void recursive(Node cur){ //this recursively pushed items from head into the stack (to be printed later)
      stack.push(cur);
      if(cur.right == null && cur.left == null){ //this is the base case for returning from leaf nodes
        return;
      }
      recursive(cur.right);
      recursive(cur.left);
      return;
    }
}  

//TODO perform placement and calculate cost during.
//TODO Implement simulated annealing
//TODO use stack to implement move functions
