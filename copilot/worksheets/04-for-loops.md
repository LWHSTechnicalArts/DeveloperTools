LOOOOOOOOOOOOPS\!   
Useful video tutorial for this concept: [https\://www\.youtube.com/watch?v=cnRD9o6odjk](https://www.youtube.com/watch?v=cnRD9o6odjk)  
  
Part 1: Controlling Repetition

| We saw that we can use function draw and a variable to make a shape repeat infinitely across (or down) the screen. But, what if you want to draw a specific number of shapes? A *for loop* will allow you to create repeated shapes (repeated anything, actually) for a set number of repetitions. You set the conditions and the number of repeats right in the loop.  |  |  |
| ----- | ----- | :---- |
|  *In this worksheet, we’ll work inside function setup because it is not already a loop.*   |  |  |
|  **For example:** Make a circle. What if you want to create 10 circles, but ONLY 10 circles, not the infinite number of circles that you get in the draw function?  You can use a for loop.  But first, make a circle. **This time draw your circle inside of setup, instead of inside of draw:**   |  |  |
| **** |  | function setup() {  createCanvas(900,400);  background(80);  fill(200,10,0);  ellipse(250,300,70,90);}function draw() {*//just leave draw empty* } |
|  Remember the variable that controls the circle’s x coordinate? Again, we’ll call it distance, as in distance from the edge of the canvas.  |  |  |
|  |  | let xValue \= 20;function setup() {  createCanvas(900,400);  background(80);  fill(200,10,0);  ellipse(xValue,300,70,90);}function draw() {*//just leave draw empty for now.* } |
| **Once again, let’s update xValue, but this time, we’ll update it with a *for loop*:**   for (*statement 1*; *statement 2*; *statement 3*) {     *code block to be executed* } **Statement 1** is executed before the loop (the code block) starts. **Statement 2** defines the condition for running the loop (the code block). **Statement 3** is executed each time after the loop (the code block) has been executed. Read more about loops in Javascript on [w3schools.com](https://www.w3schools.com/js/js_loop_for.asp)  |  |  |
|  |  | let xValue \= 20; function setup() {  createCanvas(900,400);  background(80);  fill(200,10,0);   for (let n \= 1; n\<9; n \= n+1){     ellipse(xValue,300,70,90);     xValue \= xValue \+ 100;  }} function draw() {*//just leave draw empty for now. It doesn't mind.*} |
|  Before you freak out about the crazy syntax, let’s translate this phrase into English. Try saying this aloud: “Run this loop from when the variable n \= 1 until the variable  n \= 9\. Each time you run the loop, increase the value of n by 1\. “  Here’s how you write that in code:  for (let n \= 1; n\<9; n \= n \+1)    Each time you run the loop, you do all the stuff inside the curly braces {}.   |  |  |
| **FAQ:**       **Q. Why n?**  That’s just what I chose. You could use any letter or a word, like distance or apple. One that you see in a lot of examples is *i*.       **Q. Why is *let n* inside of the parentheses instead of up at the top with the other variables?** Good question\! This time, we’re using a local variable. The only place we’re using n is inside of this for loop, so it’s easier to just define it and use it in the same place.   |  |  |
| **One final thing:**  There is a shortcut for writing n= n \+ 1\.  That shortcut is n++ (see below):  |  |  |
| let xValue \= 20;function setup() {  createCanvas(900,400);  background(80);  fill(200,10,0);  for (let n \= 1; n\<9; n++){       ellipse(xValue,300,70,90);       xValue \= xValue \+ 100;  }}function draw() {*//just leave draw empty for now. It doesn't mind.*} |  |  |
| **Try this:** Replace the ellipse with one of your own functions. Play around with the length of the loop and the values of the variables to create a design that you like.   Or, here’s a fun example: Make as many chocolate bars as you want by using the keyPressed function [Chocolate counter by Augie Nice.](https://editor.p5js.org/lizzybrooks/sketches/tBurVTwsE)  |  |  |
| **Screenshot your image and your code. Post to the blog on the loops page.**     |  |  |

****  
*Grid by Lauren*            
 **Part 2: Loop your loops to create a grid**

| Create a function for your row of shapes | function circleRow(startX, y, t){    for (let n \= 0; n\<t; n++){       ellipse(startX,y,70,90);       startX \= startX \+ 100;    }} |
| :---- | :---- |
| Create a new loop for the row.  Except this loop moves down the page instead of across.    |  |
| let rowY \= 100 function setup() {  createCanvas(400, 400);   background(220);   for(let r=0; r\<5; r++){    circleRow(100,rowY,4)    rowY \= rowY \+ 20  }}function circleRow(startX, yValue, total){    for (let n \= 0; n\<total; n++){       ellipse(startX,yValue,70,90);       startX \= startX \+ 100;    }} |  |
|  You could also skip making the function and just use a nested loop, or a loop inside a loop.   |  |
| let startX \= 40let rowY \= 100 function setup() {  createCanvas(400, 400);   background(220);   for(let r=0; r\<5; r++){    for (let n=0; n\<4; n++){       ellipse(startX,rowY,70,90);       startX \= startX \+ 100;    }    startX \= 40    rowY \= rowY \+ 50  }} |  |

**PART 3: Varying Patterns**

| IF statements The modulus operator (the remainder) % randomness |  |  |
| :---- | :---- | :---- |
| In a **brick** repeat, every other row is shifted over in the same way.   | To do this trick, you need to use the **modulo (remainder)** operator, which is written with the %.  **Say this out loud:  If row divided by two leaves a remainder of zero, do the stuff in the curly braces.** And, here’s how you write that in code:   if(row % 2 \== 0\) {  //even-numbered rows }  |  |
| let startX;let rowY \= 100 function setup() {  createCanvas(600, 700);   background(220);   for(let r=0; r\<15; r++){    if(r%2\==0){      startX \= 40    }     else{       startX=80     }    for (let n \= 0; n\<4; n++){       ellipse(startX,rowY,70,90);       startX \= startX \+ 80;    }    startX \= 40    rowY \= rowY \+ 50  }} |  |  |
| **Make your own brick repeat. Feel free to use circles or squares to learn the skill.**   |  |  |
| You can vary a repeat type by including variations on a basic form or color.  |  | Make your own block repeat with changes of color or shape in a repetitive way (for example, every 5th shape is yellow). **HINT**: This is also done using the modulo operator %.   |
| let startX \= 40let rowY \= 100 function setup() {  createCanvas(400, 400);   background(220);   for(let r=0; r\<5; r++){    for (let n \= 0; n\<4; n++){      if(r%2\==0){                fill("blue");      }        else{        fill("black")      }       ellipse(startX,rowY,70,90);       startX \= startX \+ 100;    }    startX \= 40    rowY \= rowY \+ 50  }} |  |  |
| **Make your own color variation.**   |  |  |
| In a **half-drop** repeat, every other column is moved down so that the shapes are staggered vertically. |  | **Hint:** what if rows were the inner loop and columns the outer? |
| **Make your own half-drop.**   |  |  |
| In a **random** repeat, the shapes are scattered seemingly randomly.    | function setup() {  createCanvas(800, 800); }function draw() {  //draw a random rectangle   rect(random(0, width), random(0, height), 100, 200);} |  |
| **Make your own random pattern.**  |  |  |
|  **Can you make a pattern that uses more than one function and alternates between them in a grid or a random pattern?**   |  |  |

**More BONUS content\! Canvas Transformations** 

| Explore Gene Kogan’s p5 transformations tutorial. [http\://genekogan.com/code/p5js-transformations/](http://genekogan.com/code/p5js-transformations/) Create two unique drawings using translate(), push()and pop(). Post your code and picture to the blog on the loops page.   |
| :---- |










