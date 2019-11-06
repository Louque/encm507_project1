//PUT IN DRAW
//drawtextbox();
//put in setup
  mono = createFont("Monospaced.plain", 30); //add 2 lines to setup
  textFont(mono);
//PUT IN GLOBAL
String result="";    
float x, y;
PFont mono;
float letter_width = 18.00293;

void drawtextbox() {
  fill(200, 202, 202); 
  textSize(30);
  rect(50, 20, 500, 40); // x, x-textsize, l, textsize+20
  fill(0);
  //textMode(CORNER);
  text (result, 50, 50);
}
void keyPressed() {
  if (result.length()<25) {
    if (false) {
    } else if (key == 'h' ||key== 'H') {
      result +='H';
    } else if (key == 'v' ||key== 'V') {
      result +='V';
    } else if (key == '2') {
      result +='2';
    } else if (key == '1') {
      result +='1';
    } else if (key == '3') {
      result +='3';
    } else if (key == '4') {
      result +='4';
    } else if (key == '5') {
      result +='5';
    } else if (key == '6') {
      result +='6';
    } else if (key == '7') {
      result +='7';
    } else if (key == '8') {
      result +='8';
    } else if (key == '9') {
      result +='9';
    } else if (key == BACKSPACE) {
      if (result.length()>0) {
        result = result.substring(0, result.length()-1);
      }
    }
  }
}
int last_clicked; 
int now_clicked=1;
int clickcount = 0;
void mousePressed() {
  if (result.length()>0) {
    for (int i = 0; i<result.length(); i++) {
      if (mouseX >= 50+letter_width*i && mouseX<= 50+ letter_width*i+letter_width) {
        if (clickcount == 0) {
          last_clicked = i;
          clickcount++;
        }
        else if (clickcount == 1) {
          now_clicked = i;
          clickcount--;
        }
        print(i);
      }
    }

    result = swap(result, last_clicked, now_clicked);
  }
}
public String swap(String s, int i, int j) {
  print("\n this is i and j" + i, j);
  if (i<j) {
    String s1 = s.substring(0, i); //take start of string to first click
    String s2 = s.substring(i+1, j); //take string from the letter past the first click to the letter of the second click
    String s3 = s.substring(j+1); //take the rest of the string after the second click
    print("j>1");
    return s1+s.charAt(j)+s2+s.charAt(i)+s3;
   
  } else if (j<i) {
    String s1 = s.substring(0, j); //take start of string to first click
    String s2 = s.substring(j+1, i); //take string from the letter past the first click to the letter of the second click
    String s3 = s.substring(i+1); //take the rest of the string after the second click
    print("j<1");
    return s1+s.charAt(i)+s2+s.charAt(j)+s3;
    
  } else if (i==j) {
    return s;
  }
  return s;
}
