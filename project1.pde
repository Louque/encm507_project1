///ENCM 507 Fall 2019 //<>//
///Luke Renaud and Robert Krivelis
///
///
import java.util.ArrayDeque;

String s = "12H34VH"; //MUST be a valid polish expresion THIS IS THE CURRENT USER INPUT, update with better way later.
int scalingvariable = 10; //ROBERT's favorite variable.H34VH
int textsize = 15;
char[] polish;
int sizeModifier = 50; // make this the WORST case scenario of playarea_w / (width of all boxes) which is the case with all vertical cuts OR worst case of all boxes vertically stackeda and playarea_h
float playarea_x = (1920/2)/4;
float playarea_y = (1080/2)/4;
float playarea_w = (1920/2)/2;
float playarea_h = (1080/2)/2;

int costx = 0;
int costy = 0;

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
  println("This is maybe the cost? w, h:", newtree.head.rec.w, newtree.head.rec.h);
  //should really make get functions for the Tree class to ensure bad things can't happen to the data from user functions
}
//**********Draw************
void draw() { //repeat infinitum

  //maybe drawing is best done recursively from top of tree.
}

//TODO: Add functionality that allows each H/V cut to have size of all objects below it.
//TODO perform placement and calculate cost during.
//TODO Implement simulated annealing
//TODO use stack to implement move functions <- Neighbor.
