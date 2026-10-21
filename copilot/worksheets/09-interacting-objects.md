3\. Interacting Objects  


|  Open the [cheep cheep](https://editor.p5js.org/lizzybrooks/sketches/Q3eCYXrqN) example in the p5 editor.  Push play Click inside the game area to start interactivity Use the arrows to move your avatar toward the bird Play for a while, and when you’re ready, move on to examine the code:   |  |
| ----- | :---- |
| Lines 1 and 2 create two variables, me and bird.  | let bird;let me; |
| Inside function setup, in lines 8 and 9, you are creating new objects by creating class instances and assigning them to variables.  Scroll down to see if you can find the Avatar class and the Bird class |  me \= new Avatar(width/2, 300, 3); bird \= new Bird(width, 200, \-1); |
| In function draw, in lines 16-21, you are drawing, moving and chirping your class instances, using each class’s dot-chained methods. Does this syntax look familiar?  |  me.drawMe(); me.moveMe(); bird.drawBird();  bird.moveBird(); bird.chirp();  |
|  **There are two new features in this game: keyboard controls and reactions**  |  |
| **Keyboard Controls** Can you figure out how to move the avatar by looking at the code?  (hint: look at line 49\)  |  |
| **The Avatar class constructor has inputs for x, y and speed properties.**   Check line 28-32 in the constructor function. This constructor signature is where you find the inputs for the avatar instances.   | constructor(x,y, speed){ 		this.x \= x;    		this.y \= y;            this.speed \= speed;	} |
| **In the moveMe method, you are changing the particular instance’s x and y location by adding or subtracting speed.**   this.y \-= this.speed is a shortcut for writing this.y \= this.y-speed.  speed is added or subtracted to x and y with each arrow press.  | moveMe(){    if (keyIsDown(UP\_ARROW)) {        this.y \-= this.speed;      }      if (keyIsDown(DOWN\_ARROW)) {         this.y \+= this.speed;      }    if (keyIsDown(LEFT\_ARROW)) {      this.x \-= this.speed;      }    if (keyIsDown(RIGHT\_ARROW)) {      this.x \+= this.speed;      }  } |
|  **How to detect collisions?**  We want the bird to know when it lands on the avatar.   |  |
| **Where is the bird?   Where is the avatar?** You can find any instance’s location by referencing the instanceName.x or y So, me.x, me.y is the x and y location of me.  Try printing it: add the text on the right into function draw()  Then, move your avatar around and watch their location print in the console.   |   print(me.x,me.y) |
|  So, you should be able to say if me.x \= bird.x and me.y \= bird.y, cheep.  That’s basically what we’re doing, except that instead of saying me.x \= bird.x, we’re basically drawing a box around the avatar and saying that if the bird is within that box, then cheep.  The reason for that is the code is more reliable when there’s a range. It prevents the game from skipping (e.g. the avatar is moving so fast that it doesn’t register the bird).   |  |
| **This insane conditional statement checks whether the bird is overlapping with the avatar:**   If the bird’s x-value is greater than the avatar’s x-value minus 15 And the bird’s x-value is less than the avatar’s x-value plus fifteen And the bird’s y-value is greater than the avatar’s y-value minus 40  And the bird’s y-value is less than the avatar’s y value plus 40 | if (this.x \>= me.x\-15 && this.x \<= me.x+15 && this.y \> me.y\-40 && this.y \< me.y+40) {                   } |
| **Double && signs allow you to link conditions in one statement.**  | this.x \>= me.x\-15 && this.x \<= me.x+15 |
| **If the conditions are met, the bird stops moving and text appears:** It’s important to note that the movement change and the text are both inside the { } for the conditional statement And the whole thing is inside the { } for a function called cheep() Always check your brackets when you’re adding conditionals\!   | this.speed \= 0;text("cheep cheep", this.x,this.y); |
|  **Take some time to play around with these features Make a small game**  |  |

**Part 2: You can also create interactivity for a lot of objects at once**

| Open the [bouncing balls](https://editor.p5js.org/lizzybrooks/sketches/MUKqLo-2u) example in the p5 editor.  Push play Click inside the game area to start interactivity Use the arrows to move your avatar and deflect the balls Play for a while, and when you’re ready, move on to examine the code:  |  |
| ----- | :---- |
| First create containers to hold the objects that you’ll make:  At the top of the sketch, you’ll see:  An empty array to hold the balls A single variable to hold the avatar | let balls \= \[\];let me; |
| In setup, you add a new Avatar into the variable, me.  | me \= new Avatar(width/2, 300, 3); |
| Inside function draw(), you are drawing and moving your avatar  |  me.drawMe(); me.moveMe(); |
| **frameCount** frameCount is a built in timer in p5 Look it up in the [reference](https://p5js.org/reference/#/p5/frameCount) Here, you’re making a new ball every 2 seconds, and pushing it into the balls array frameCount allows you to put a timer into your sketch  | if (frameCount % 60 \== 0) { let  b \= new Ball(width,random(0,height), \-3);      balls.push(b);        } |
| **%**  You can use the % (modulus operator) to specify that something happens only on multiples of a certain frameCount.  So, in this case, if frameCount is evenly divisible by 60, then the program will create a ball.  That’s just a little faster than once every second.   | if (frameCount % 60 \== 0) {  |
| Use a for loop to run through all the balls you’ve made: Draw them Move them Bounce them These functions are all defined in your ball class  | for (let i \= 0; i \< balls.length; i++) {	 	  balls\[i\].drawBall();       	  balls\[i\].moveBall();        	  balls\[i\].bounceBall();	  } |
| Just like with the chirping bird, the bouncing of the ball is created with an epic if statement: If the ball overlaps the avatar, the speed becomes negative   | bounceBall(){    if (this.x \>= me.x\-15 && this.x \<= me.x+70 && this.y \> me.y\-40 && this.y \< me.y+40){       this.speed \= \-this.speed;     		} } |
|  **Use these examples to add interactivity to your own game\!  Use the ideas below as a starting point.**    |  |
|  **POST THE FOLLOWING INFO TO THE BLOG:**   Title your first post with today’s date and Interacting Objects  Post a screenshot or gif of your sketch. If you have a mac, I recommend using the [GIPHY CAPTURE](https://giphy.com/apps/giphycapture) software to create animated gifs.  Post a link to your code Write a 1-2 sentence description of your learning.  |  |

