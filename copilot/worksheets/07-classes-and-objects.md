1. CLASS —\> OBJECTS



Objects and Classes in p5 & JavaScript

|  You will create a class (like a template) and from that class, create some objects.  [Here is an example](https://editor.p5js.org/lizzybrooks/sketches/F3wF6ePwk) for you to use as a reference.   |  |
| ----- | ----- |
|  **TO START:  *OPEN [THIS TEMPLATE](https://editor.p5js.org/lizzybrooks/sketches/BXLCMo5Ti) — use the instructions below to understand how it works, then make your own class with something besides a ball.***   |  |

| Create a class:   At the bottom of your sketch, below setup and draw, add the code on the right.  You are creating a class, *ball*, which is like a template from which many individual balls will be made.   | class Ball { *// here is where you'll put the instructions for making balls*} |
| ----- | :---- |
| **The Constructor:**  Add a constructor function to your ball class (copy and paste the code on the right). The constructor ensures that every ball you make will have a unique position in space (x,y) and its own color.  Think of the constructor as a function with inputs that runs every time you make a new ball.  **What is THIS.X ???** The word ***this*** is very special. It allows you to specify that each ball will have its own data, (e.g. x, y, and color) particular to THIS ball.   | class Ball { constructor(x,y,color){ 		this.x \= x;    		this.y \= y;            this.color \= color;	  } } |
|  **Add a new property to your ball constructor, like diameter, or outline**  |  |

| Functions in the Class:   Copy and paste the code on the right to add functions to your Ball class. Balls created from the ball class all have similar abilities. In this case, they can appear, and they can move.  Notice that when you’re putting a function inside a class, you don’t need the word function drawBall anymore. Weird.   | drawBall(){     	   stroke(0);    	   fill(this.color);         ellipse(this.x,this.y,10,10);	}moveBall(){ 	   this.x \= this.x+2;	   this.y \= this.y+.5;	} |
| :---- | :---- |
|  **Change the appearance of your ball so it uses the new inputs you created in the constructor.**   |  |
|  **Add a new function to the Ball class (see examples below and be creative).**   |  |
| **Example:**  | shrink(){ 	   this.diameter \= this.diameter \-2;	}  |
| **Example:**  | spawnFriend(){ 	   fill(this.color);          ellipse(this.x+20,this.y,10,10); 	}  |

|   Now let’s create some objects from your class\!   |  |
| ----- | :---- |
| **Create a variable to hold your first object:**   To create a new ball from the ball class, you first make a variable to hold that ball.   | let b;  |
| **Use the Ball class to create an object and put it into your variable:**   Use the word **NEW** to specify that you’re creating a ball from the class.  When you make the new ball, you add the data that the constructor requires.  Check the constructor in your own Ball class to see what inputs  your ball requires.   | b \= new Ball(0, 100,"red");     |
|  **Create a second variable and put another ball into it.  Assign different properties to the second ball.**   |  |

|  You still need to call your Ball functions   |  |
| ----- | :---- |
| **Go check what your ball is able to do:**  Scroll down to your Ball class to see what functions are available for your new ball, b  | drawBall(){     	   stroke(0);    	   fill(this.color);         ellipse(this.x,this.y,10,10);	}  |
| **Call a ball function for b**   To call the function specifically on the b object, you need to attach the function to b.   | function draw(){	background(220);      b.drawBall();       b.moveBall();} |
|   **Now you can push PLAY and your ball should appear and move\!**  |  |
|  **Play around with this example and have some fun.**   |  |

|  Writing New Classes You can add multiple classes to your sketch.   |  |
| ----- | ----- |
|  **Create a new class, maybe a person class (for people playing a ball game) or a tree class (if you changed your ball into a bird), etc.  Use the same structure as the ball class  Use your new class to add a collection of unique objects of a single type to your sketch.**   |  |
| **Customize the sketch  POST THE FOLLOWING INFO TO THE BLOG:**   Make a sub-page for your work in this unit under the Mini-Game menu Title your first post with today’s date and Objects/Classes  Post a screenshot or gif of your sketch.  Post a link to your code Write a 1-2 sentence description of what is an object and a class.   |  |

