  
TRANSLATE: an easy way to grid  
 by Nevin Chin

| DRY: Programmer acronym for “*Don’t Repeat Yourself*” when writing code. “Don’t repeat yourself. It’s not only repetitive, it’s redundant, and people have heard it before.” \-Daniel Handler, Author of A Series of Unfortunate Events Loops can help you write more concise code\! Code readability is also important, and sometimes making something clear is more important than making it fit in as few lines as possible. |
| :---- |

**CONCEPTS IN THIS WORKSHEET**: 

* **Translate** \= moving the “paper” underneath your design  
* **Nested loops** \= a loop inside a loop (e.g. repeating a horizontal pattern vertically  
* **Push/Pop** \= a way to “save your place” when using translate  
* Modulo Operator \= % , a way to check if something is evenly divisible and then select for that

****  
Patterns by Eujean Doo and Brandon Moore  
**PART 1: An easier way to repeat**

| translate push and pop |  |  |
| :---- | :---- | :---- |
| What if you made a really cool shape, and you wanted to repeat it, but you were too lazy to figure out all the math to make it repeatable…  |  |  |
| function setup() {  createCanvas(400, 400);}function draw() {  background(220);  myShape() }function myShape(){   strokeWeight(2)  line(20,30, 60,30)  line(60,30, 25, 70)  line(25,70,60,70)  noFill()  arc(55, 95, 60, 50, PI/2, 3\*PI/2)} |  |  |
| You could use a function called **translate()** to slide the canvas underneath the shape.  |  |  |
| function draw() {  background(220);  myShape();  translate(100,0);  myShape();} |  |  |
| Try doing the whole row  |  |  |
| function draw() {  background(220);  myShape();  translate(100,0);  myShape();   translate(100,0);  myShape();   translate(100,0);  myShape();} |  |  |
| Can you make the translation vertical instead? HINT: translate with the y-value   translate(0,100); |  |  |
| Wait— this is looking repetitive. Let’s add a loop.  |  |  |
| function draw() {  background(220);  for (let n \=0; n \<4; n++){    myShape();    translate(100,0);      }} |  |  |
| Let’s add another row. For the purposes of the example, I’m making the canvas a little bigger.  |  |  |
| function setup() {  createCanvas(600, 400);}function draw() {  background(220);  for (let n \=0; n \<4; n++){    myShape();    translate(100,0);      }  translate(0,100);   for (let n \=0; n \<4; n++){    myShape();    translate(100,0);      }}  |  |  |
| Our canvas is way out of position. We’re stuck on the right side. We need to POP back into position.  The **push()** and **pop()** functions allow you to push a pin into the canvas before translating, and then pop back to that position.  |  |  |
| function draw() {  background(220);  push();   for (let n \=0; n \<4; n++){    myShape();    translate(100,0);      }  pop();   translate(0,120);  for (let n \=0; n \<4; n++){    myShape();    translate(100,0);      }} |  |  |
| The last piece of a beautiful grid is to nest the horizontal loop inside the vertical loop, so there’s even less text  |  |  |
| function draw() {  background(220);  for (let rows \= 0; rows\<3; rows++){      push();       for (let n \=0; n \<4; n++){      myShape();      translate(100,0);          }    pop();     translate(0,120);     }} |  |  |

**PART 2: Varying Patterns**

| IF statements modulus operator (the remainder) % randomness |  |  |
| :---- | :---- | :---- |
| In a **brick** repeat, every other row is shifted over in the same way.   | To do this trick, you need to use the **modulo (remainder)** operator, which is written with the %.  **Say this out loud:  If row divided by two leaves a remainder of zero, do the stuff in the curly braces.** And, here’s how you write that in code:   if(row % 2 \== 0\) {  //even-numbered rows } Run the below example, and here is some more code to play with that further: [https\://gist.github.com/lizzybrooks/de4f4ba5057b5ae63592b4c75b78e779](https://gist.github.com/lizzybrooks/de4f4ba5057b5ae63592b4c75b78e779) |  |
| function draw() {  background(220);  for (let rows \= 0; rows\<3; rows++){      push();          if(rows%2\==0){        translate(37,0);          stroke("blue");      }          for (let n \=0; n \<4; n++){      myShape();      translate(100,0);          }    pop();     translate(0,120);     }} |  |  |
| **Make your own brick repeat. Feel free to use circles or squares to learn the skill.**   |  |  |
| You can vary a repeat type by including variations on a basic form or color.  |  | Make your own block repeat with changes of color or shape in a repetitive way (for example, every 5th shape is yellow). **HINT**: This is also done using the modulo operator %.   |
| **Make your own color variation.**   |  |  |
| In a **half-drop** repeat, every other column is moved down so that the shapes are staggered vertically. |  | **Hint:** what if rows were the inner loop and columns the outer? |
| **Make your own half-drop.**   |  |  |
| 19\. In a **random** repeat, the shapes are scattered seemingly randomly.    | function setup() {  createCanvas(800, 800); }function draw() {  //draw a random rectangle   rect(random(0, width), random(0, height), 100, 200);} |  |
| **Make your own random pattern.**   |  |  |

| Congratulations\! You learned a lot of new skills\! Use some or all of the processes in this worksheet to make an interesting pattern that repeats on the canvas.   To turn in your work, post to the grid page of the blog:  Your name, today’s date A screenshot of what you made (it’s okay if it’s just your own version of one of the examples) A link to your code A brief description of what you learned  |
| :---- |















