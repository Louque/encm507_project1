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
        //tempnode.rec =  new rect_class(1, 0, 0, (int) random(1, 4)*scalingvariable, (int) random(1, 4)*scalingvariable);
        tempnode.rec =  new rect_class(1, 0, 0, 1*scalingvariable, 2*scalingvariable);
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
