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
