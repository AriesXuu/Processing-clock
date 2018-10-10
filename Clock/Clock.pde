import processing.sound.*;
import controlP5.*;

ControlP5 cp5;
Textarea myTextarea;
SoundFile alarmSound;
String alarmSoundFile = "boxing.wav";

boolean toggle = false;
boolean snooze = false;
boolean snooze2 = false;
boolean checktime = false;
boolean checktimeagain = false;
boolean checktimeagainagain = false;

String text_hint = "Set time please";
int myColorBackground = color(0,0,0);

int[] delayTime = {1,2,3,4,5}; 
int index = int(random(delayTime.length));
int x, y, i, k;
PFont f;
String textField_Hour, textField_Min, textField_Sec;
int setHour, setMin, setSec, setNewMin, setNewMin2;
int clickNum = 5;
int xx , yy;
void setup()
{
  cp5 = new ControlP5(this);
  PFont font = createFont("Verdana",10);
  xx = 0;
  size(350, 600,P2D);
  x=width/2;
  y=height/5;
  smooth();
  f = createFont("HelveNueThin", 55);
  textFont(f);
  
  alarmSound = new SoundFile(this, alarmSoundFile);
  
  cp5.addTextfield("Hour")
     .setPosition(100,330)
     .setSize(60,20)
     .setFont(font)
     .setFocus(true)
     .setColorBackground(color(255))
     .setColorActive(color(90,195,244)) 
     .setColorValueLabel(color(0))
     .setColorForeground(color(79,83,89)) 
     ;
  
  cp5.addTextfield("Min")
     .setPosition(180,330)
     .setSize(60,20)
     .setFont(font)
     .setFocus(true)
     .setColorBackground(color(255))
     .setColorActive(color(90,195,244)) 
     .setColorValueLabel(color(0))
     .setColorForeground(color(79,83,89)) 
     ;
  
  cp5.addTextfield("answer")
     .setPosition(190,480)
     .setSize(100,25)
     .setFont(font)
     .setFocus(true)
     .setColorBackground(color(255))
     .setColorActive(color(90,195,244)) 
     .setColorValueLabel(color(0))
     .setColorForeground(color(79,83,89)) 
     .hide();
      
  
  cp5.addButton("Snooze")
     .setPosition(123,410)         
     .setFont(font)
     .setSize(100,20);
     
  cp5.addButton("SetTime")
     .setPosition(123,380)
     .setFont(font)
     .setSize(100,20);
     
  cp5.addButton("Clickme")
     .setPosition(123,450)
     .setFont(font)
     .setSize(100,20)
     .hide();
     
  cp5.addButton("Getup")
     .setPosition(123,430)
     .setFont(font)
     .setSize(100,20);
     
  cp5.addButton("Enter")
     .setPosition(135,530)
     .setFont(font)
     .hide();

  myTextarea = cp5.addTextarea("txt")
                  .setPosition(0,100)
                  .setSize(350,100)
                  .setFont(createFont("arial",80))
                  .setLineHeight(14)
                  .setColor(color(229,32,32))
                  .setColorBackground(color(255,100))
                  .setColorForeground(color(255,100));
                  
  myTextarea.setText("Get UP!!!") 
            .hide();
              
  myTextarea = cp5.addTextarea("question")
                  .setPosition(50,480)
                  .setSize(120,25)
                  .setFont(createFont("arial",14))
                  .setLineHeight(14)
                  .setColor(color(0))
                  .setColorBackground(color(255,100))
                  .setColorForeground(color(255,100));
                  
  myTextarea.setText("1 + 2 * 9 + 8 = ?")
            .hide();
                      
      
}





void draw()
{
  background(200);
 
  int s = second();
  int m = minute();
  int h = hour();
  textField_Min = cp5.get(Textfield.class, "Min").getText(); 
  textField_Hour = cp5.get(Textfield.class, "Hour").getText();

  setMin = int(textField_Min); 
  setHour = int(textField_Hour);
  
   
  if (m == setMin && h == setHour){
    checktime = true;
  } else {
    checktime = false;
  }
  
  if (m == setNewMin && h == setHour){
    checktimeagain = true; 
  } else {
    checktimeagain = false;
  }

  if (m == setNewMin && h == setHour){
    checktimeagainagain = true; 
  } else {
    checktimeagainagain = false;
  }
  
  if(checktime && toggle){
    println("playing");
    alarmSound.loop();
    alarmSound.amp(0.5);
    checktime = false;
    toggle = false;
    println("1");
  }
  
  if(checktimeagain && snooze){
    println("playing");
    alarmSound.loop();
    alarmSound.amp(2);
    checktimeagain = false;
    snooze = false;
    println("2");
  }
  
  if(checktimeagainagain && snooze2){
    println("playing");
    alarmSound.loop();
    alarmSound.amp(3);
    checktimeagainagain = false;
    snooze2 = false;
    println("3");
  }
  
  k = h;

  //------------------------
  noStroke();
  fill(255);
  ellipse(x, y, 300, 300);
  //------------------------
  pushMatrix();
  translate(x, y);
  rotate(radians(6*s));
  stroke(0);
  line(60, 60, 100, 100);
  popMatrix();
  //------------------------
  fill(24, 24, 24);
  noStroke();
  ellipse(x, y, 150, 150);
  //------------------------
  fill(#00A3F7);
  textAlign(CENTER);
  if (m<10)
  {
    textSize(55);
    text(k+":0"+m, x, y+20);
  }
  else {
    textSize(55);
    text(k+":"+m, x, y+20);
  }
  if (h<12 || h==12) {
    textSize(20);
    text("AM", x, y+40);
  }
  else
  {
    textSize(20);
    text("PM", x, y+40);
    
  }
 
  fill(0);
  textSize(13);
  text(text_hint, 173, 310);  
      
}


void SetTime() {  
  textField_Hour = cp5.get(Textfield.class, "Hour").getText();
  textField_Min = cp5.get(Textfield.class, "Min").getText();
  text_hint = "You set alarm at " +textField_Hour+ ":" +textField_Min;
  toggle = true;
}

void Snooze() {
  int setMin = minute();
//_____________first click snooze
  if (checktime == true && clickNum > 0) 
    { 
      alarmSound.stop();
      setNewMin = setMin + delayTime[index];
      text_hint = "Snooze " +delayTime[index]+ " minutes";   
      snooze = true;
      clickNum = clickNum - 1;
      println("first");
      println("Snooze " +delayTime[index]+ " minutes");
    }
//_____________second click snooze    
      if (checktimeagain == true && clickNum > 0 && clickNum != 2)
    { 
      setNewMin = setMin + delayTime[index];
      text_hint = "Click button to delay";   
      snooze = true;
      clickNum = clickNum - 1;
      println("second");
      cp5.get(Button.class, "Clickme").show();
      println("Snooze " +delayTime[index]+ " minutes");
    }
//_____________third click snooze      
      if (checktimeagainagain == true && clickNum == 2 )
    { 
      setNewMin = setMin + delayTime[index];
      cp5.get(Button.class, "Enter").show();
      cp5.get(Textfield.class, "answer").show();
      cp5.get(Textarea.class, "question").show();
      cp5.get(Button.class, "Clickme").hide();
      snooze2 = true;
      clickNum = clickNum - 1;
      text_hint = "Answer the question to delay"; 
      println("third");
      println("Snooze " +delayTime[index]+ " minutes");
    }
//____________last click snooze
   if (clickNum == 0){
       cp5.get(Textarea.class, "txt").show();
       cp5.get(Button.class, "Clickme").hide();
       println("last");
   }
   
}

void Clickme(){
    alarmSound.stop();
    cp5.get(Button.class, "Clickme").hide();
    int setMin = minute();
    
  if (checktime == true)
    { 
      alarmSound.stop();
      setNewMin = setMin + delayTime[index];
      text_hint = "Snooze " +delayTime[index]+ " minutes";   
      snooze2 = true;
    }
    println("alarm stop");
}

void Enter(int answer){
  answer = int(cp5.get(Textfield.class, "answer").getText());
  if (answer == 27){
    text_hint = "Correct!";
    alarmSound.stop();
    setNewMin = setNewMin + delayTime[index];
      cp5.get(Button.class, "Enter").hide();
      cp5.get(Textfield.class, "answer").hide();
      cp5.get(Textarea.class, "question").hide();
    snooze = true;
  }else{
    text_hint = "Incorrect, Try again";     
  }  
}

void Getup(){
    alarmSound.stop();
    println("alarm stop");
    clickNum = 5;
}