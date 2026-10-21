**Radial Patterns**  
****  
**Radial patterns by Regan Fenrick, Ylva Bosemark, Jeannie Moreno and Charley Ostrow**

| The rotate function in p5 allows you to rotate the canvas.  But, it always rotates from the origin point, (0,0) To create rotational symmetry, you can use this trick:  Use translate to move (0,0) out of the top right corner, then draw your shape at (0,0)   |  |
| ----- | :---- |
|  |  |
| **Try this:**  Draw a rectangle approximately in the center of your screen, tilted to the right about 20 degrees.  Note: just like arc, the rotate command expects radians. You can use radians directly, use the **radians** function to convert, or set your [**angle mode**](https://p5js.org/reference/#/p5/angleMode) to degrees. |  |
| function setup() {  createCanvas(500, 500);  angleMode(DEGREES)}function draw() {  background("lightblue");  translate (200,200)    rotate(45)  rect (0,0,50,50)  } |  |
| By repeatedly rotating the canvas and drawing a shape, we can create  radial pattern, like the petals of a flower.  Can you see how a loop might be used to simplify the below code?  |  |
| function setup() {  createCanvas(500, 500);  angleMode(DEGREES);}function draw() {  background("lightblue");  translate (200,200);    rotate(45);  rect (0,0,50,50);  rotate(45);  rect (0,0,50,50);    rotate(45);  rect (0,0,50,50);    rotate(45);  rect (0,0,50,50);    rotate(45);  rect (0,0,50,50);  rotate(45);  rect (0,0,50,50);  } |  |
| When we rotate, our canvas moves out of position. The whole canvas is tilted all the way to the right.  It can be helpful to reset or POP back to normal before doing another rotation.  The **push()** and **pop()** functions allow you to push a pin into the canvas before rotating, and then pop back to that position.  |  |
|  In the below example, we’ve added a loop and offset the ellipse.  Instead of drawing the ellipse at (0,0) we’re drawing it at (100,0)  Try changing the coordinates to (50,0) Try changing the angle of rotation to 12 degrees Can you make more ellipses in the rotation? (review the loops worksheet) |  |
| function setup() {  createCanvas(500, 500);  angleMode(DEGREES);}function draw() {  background("lightblue");  translate (200,200);    for(let n \= 0; n\<10; n++){    rotate(36);    ellipse (100,0,50,70);  }} |  |
| Using rotate, push and pop, here is some example code that rotates a design (copy and paste into your editor to see it in action\!): |  |
| function setup() {  createCanvas(500, 500);  angleMode(DEGREES)}function draw() {  background("lightblue");  translate (75,80)    push();  rotate(15)  bear (0,0)  pop()    translate (150,0)    push();  rotate(45)  bear (0,0)  pop();    translate (150,0)    push();  rotate(\-60)  bear (0,0)  pop();   }function bear(x,y){  strokeWeight(5)  stroke(153, 98, 43)  ellipse(x\-34,y\-37,27,30)  ellipse(x+34,y\-37,27,30)  strokeWeight(5)  fill("white")  stroke(153, 98, 43)  ellipse(x,y,100,80)  strokeWeight(5)  stroke("white")  fill("white")  ellipse(x\-36,y\-32,10,10)  ellipse(x\-30,y\-35,10,10)  ellipse(x+36,y\-32,10,10)  ellipse(x+30,y\-35,10,10)  strokeWeight(7)  stroke(153, 98, 43)  ellipse(x\-14,y\-15,1,1)  ellipse(x+14,y\-15,1,1)  ellipse(x,y\-10,1,1)} |  |
|  Bear by Birdie Kwan |  |
| Here’s an example of the bear in a radial pattern (code is below the image)  |  |
| function setup() {	createCanvas(400, 400);	rectMode(CENTER);}function draw(){	background(240);	translate(width/2, height/2);	for (var i \= 0; i \< 8; i++) {		push();		rotate(TWO\_PI \* i / 8);        bear(100,0)		pop();	}} |  |
| Create your own radial pattern of your own using [bezier shapes.](https://p5js.org/reference/p5/bezier/)                |  |
|  CONGRATULATIONS\! You can use this skill for your textile.    Pattern by Danny Santana |  |

# More Resources: 

## [https\://archive.p5js.org/learn/curves.html](https://archive.p5js.org/learn/curves.html) (Learn about all curves\!) 

## [https\://editor.p5js.org/allison.parrish/sketches/H1QQ3Nt67](https://editor.p5js.org/allison.parrish/sketches/H1QQ3Nt67) (Bezier Curves) 

## 














