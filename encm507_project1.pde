///ENCM 507 Fall 2019 //<>// //<>//
///Luke Renaud and Robert Krivelis
///
/// General Description: This is a fun game to see if you can write a polish expression.
/// Use the number keys and letters v and h to make a polish expression! The FUN part is if it doesn't work the program crashes!
///
///general TODOS:
///make it work
///Input Keys to use:
//,---,---,---,---,---,---,---,---,---,---,---,---,---,-------,
//|   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 0 |   |   |<bckspc|
//|---'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-----|
//|     |   |   |   |   |   |   |   |   |   |   |   |   |     |
//|-----',--',--',--',--',--',--',--',--',--',--',--',--'-----|
//|     |   |   |   |   |   | H |   |   |   |   |   |  Enter  |
//|------'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'--------|
//|        |   |   |   | V |   |   |   |   |   |   |          |
//|------,-',--'--,'---'---'---'---'---'---'-,-'---',--,------|
//|      |  |     |                          |      |  |      |
//'------'  '-----'--------------------------'------'  '------'
///
///
import java.util.ArrayDeque;

String s = "12H534VHV";
int scalingvariable = 25; //ROBERT's favorite variable. 
//^^ make this the WORST case scenario of playarea_w / (width of all boxes) which is the case with all vertical cuts OR worst case of all boxes vertically stackeda and playarea_h
int textsize = 15;

int globalid = 0; // this is initally set when we make the rectangles
rect_class globalrects[] = new rect_class[100]; // pls don't make more than 100 nodes, or else this fills
int sizeModifier = 50; 
float playarea_x = (1920/2)/4;
float playarea_y = (1080/2)/4;
float playarea_w = (1920/2)/2;
float playarea_h = (1080/2)/2;

boolean reprintflag = false;

//make clickable text code:
String result=s;    
//float x, y; // these are dangerous to have as globals, maybe change them?
PFont mono;
float letter_width = 18.00293;

int costx = 0; // these are for calculating the cost
int costy = 0;
ArrayDeque printstack;
Tree  T;
Tree newtree; //duhhhh can't just clone trees without writing a clone function. gah


//**********Setup************
void setup() {
  size(960, 540);
  background(255);

  mono = createFont("Monospaced.plain", 30); //add 2 lines to setup
  textFont(mono);


  printstack = new ArrayDeque();
  T = new Tree(); //the giving tree
  T.add(s.toCharArray()); //call function to add the polish expression into the Tree T
  T.traverseprint(); //testing this to show it makes the tree correctly


  fill(230, 230, 220);
  rect(playarea_x, playarea_y, playarea_w, playarea_h); //creates play area. playarea_variables will be used as part of placement as well.



  newtree = new Tree(); //hacky way of doing this in order to make sure it is displaying correctly
  newtree.add(s.toCharArray());
  newtree.setsizesrandom();
  newtree.recursiverects(newtree.head); // need to call once to fill positional values and print inititally // fill print stack
  //should really make get functions for the Tree class to ensure bad things can't happen to the data from user functions
}
//**********Draw************
void draw() { //repeat infinitum
  background(255);
  stroke(0, 0, 0);
  fill(230, 230, 220);
  rect(playarea_x, playarea_y, playarea_w, playarea_h); //creates play area. playarea_variables will be used as part of placement as well.

  printprintstack(new colour(200, 200,255));


  fill(0, 0, 0);
  text("COST:", playarea_x+playarea_w/2 - textsize*4, playarea_y - 50);
  text((costx*costy)/(scalingvariable*scalingvariable), playarea_x+playarea_w/2, playarea_y - 50);
  drawtextbox(); // pressing enter sets the polish expression in the text box to the display

  fill(0, 0);
  stroke(255, 0, 0);
  rect(playarea_x, playarea_y, costx, costy);
  stroke(0, 0, 0);
  fill(0, 0);
  rect(playarea_x, playarea_y, playarea_w, playarea_h);
  //maybe drawing is best done recursively from top of tree.
}
//TODO Implement simulated annealing
//TODO use stack to implement move functions <- Neighbor.
