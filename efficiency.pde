int initialPopulationSize =999;

ArrayList < Agent > population;
ArrayList < Agent > survivors;
ArrayList <Agent> sickAgents;

int dayCounter = 0;

int framesPerDay = 60;

int currentPopulationSize = 0;

float popFluxRate = 0.001250;

PFont myFont;

PFont altFont;

PImage healthZone;

//////////////////////// infection variables

int minDays = 3;

int maxDays = 7;

int spreadDistance = 5;

int contactDistance = 15;

float infectionProbability = .10;

float travelProbability;

float isolationProb;

int xStat = 740;


int yTitle = 38;

int yDay = 455;

int yPop = 560;

int yHealthy = 537;

int ySick = 505;

int yInfect = 480;

int ySurvivors = 320;

int yDead = 380;

 int yCFR = 713;

boolean isSetup = false;

int numDead = 0;

//FloatList sickHistory;
HashMap<Integer,Float> sickHistory;
float xCord1;

boolean s1 = true;
boolean s2 = false;
boolean s3 = false;
boolean s4 = false;
boolean s5 = false;

boolean su1 = true;
boolean su2 = false;
boolean su3 = false;
boolean su4 = false;
boolean su5 = false;

boolean ct1 = true;
boolean ct2 = false;
boolean ct3 = false;
boolean ct4 = false;
boolean ct5 = false;

boolean a1 = true;
boolean a2 = false;
boolean a3 = false; 
boolean a4 = false; 
boolean a5 = false;


int yPercent  = 245; //23+button
int yPercent2 = 310;
int yPercent3 = 374;
int yButton1  = 223;
int yButton2  = 289;
int yButton3  = 353;
int yRvalue   = 235;

int contactDays = 0;
int yAssumption = 80;
int yStats = 420;

boolean pause = false;
boolean about = false;
boolean play = true;

PImage virs;
PImage hhi;

boolean adjust = false;
boolean adjust2 = false;
boolean over = false;

void setup()

{
    size(1120,740);
    frameRate(60);
   sickHistory =     new HashMap<Integer,Float>();
    population = new ArrayList<Agent>();
    sickAgents = new ArrayList<Agent>();
    myFont = createFont("Arial Black", 32);
    altFont = createFont("Arial", 32);
    initailizePop();
    virs = loadImage("DATA/virslogo.png");
    hhi = loadImage("DATA/hhilogo.png");
}

void draw()

{
    background(38,38,38);
    fill(38,38,38);
    stroke(255);
    strokeWeight(2);
    println(frameRate);
//println(sickAgents.size());
   rect(20,20,width-420,700,6); 
    stroke(150);
    line(xStat,yAssumption+10,xStat+360,yAssumption+10);
    line(xStat,yButton1-35,xStat+360,yButton1-35);
    line(xStat,yStats+10,xStat+360,yStats+10);
    for (Agent a: population){
      if(isSetup){
        a.update(); 
       }
     }
     
      for (Agent a: sickAgents){
      if(isSetup){
        a.update(); 
       }
     }

///////////////////////////////////////////////////////////////////////////YEARLY CENSUS

    if (frameCount % framesPerDay == 0)
    {
        currentPopulationSize = population.size();
        dayCounter += 1;
        removeAgent();
          
    }

    infect();
    statsBar();
    //if(isSetup && frameCount % 2 == 0){
    //  saveFrame("output/#####.png");
    //}
    
}

void removeAgent() {
  for (int i = population.size() - 1; i >= 0; i--) {
          Agent d = population.get(i);
        if (d.dead == true) {
          population.remove(i); 
          
          noStroke();
          fill(138, 43, 226,100);
          ellipse( d.loc.x, d.loc.y, 16, 16);
          numDead  += 1;
        
     } 
    }
    for (int i = sickAgents.size() - 1; i >= 0; i--) {
          Agent d = sickAgents.get(i);
         if (d.dead == true) {
          population.remove(i); 
          
     } 
    }
   } 

////////////////////////////////////////////////////////////////////////////// STATS BAR  

void statsBar() {

    float popSize = population.size();   
    float totalPop= popSize + numDead;
    float numInfected = 0;
    float numHealed = 0;
    float numHealthy = 0;
    float numSick = 0;
    
    for (Agent person: population) {

        if (person.sick == true) {

            numSick += 1;

        }
         if (person.infected == true) {

            numInfected += 1;

        }
         if (person.recovered == true) {

            numHealed += 1;

        }
         if (person.dead == false && person.recovered == false && person.infected == false && person.sick == false) {
            numHealthy += 1;
        }

    }
   
  
    
    float numAffected = numHealed + numDead + numInfected + numSick;
    
    //println("num" + numAffected);
    
    float percentSick = numSick / totalPop * 100;
    float percentInfected = numInfected / totalPop * 100;
    float percentHealed = numHealed / totalPop * 100;
    float percentDead = numDead / totalPop * 100;
    float percentCFR = (numDead / (numHealed + numDead)) * 100;
    float percentHealthy = numHealthy / popSize * 100;
    float percentAffected = numAffected / totalPop * 100;
    
    float xScale = 100;
    float xHealthy = map(percentAffected, 0, xScale, 0, 360);

    float xSick = map(percentSick, 0, xScale, 0, 360);

    float xInfected = map(percentInfected, 0, xScale, 0, 360);

    float xSurvivors = map(percentHealed, 0, xScale, 0, 360);

    float xDead = map(percentDead, 0, xScale, 0, 360);
    
    fill(255);
    textAlign(LEFT);
    textFont(altFont);
    textSize(14);
    
    noStroke(); 
    textAlign(LEFT);
    
    if(mouseX > xStat && mouseX < xStat+125 && mouseY > yAssumption+35-20 && mouseY < yAssumption+35){
    fill(80,200);
    rect(xStat-350,yAssumption+19,320,56,7);
    fill(220);
    text("The incubation period is the time between",xStat-340,yAssumption+43);
    text("exposure to infection and becoming infected.",xStat-340,yAssumption+63);
    }
    
    if(mouseX > xStat + 200 && mouseX < xStat+360 && mouseY > yAssumption+35-20 && mouseY < yAssumption+35){
    fill(80,200);
    rect(xStat-350,yAssumption+19,320,56,7);
    fill(220);
    text("Susceptibility is the proportion of the population",xStat-340,yAssumption+43);
    text("not immune to the virus and vulnerable.",xStat-340,yAssumption+63);
    }
    
    if(mouseX > xStat && mouseX < xStat+125 && mouseY > yAssumption+60-20 && mouseY < yAssumption+60){
    fill(80,200);
    rect(xStat-350,yAssumption+44,320,56,7);
    fill(220);
    text("The infection period is the contagious stage.",xStat-340,yAssumption+68);
    text("An agent can be symptomatic or asymptomatic.",xStat-340,yAssumption+88);
    }
    
    if(mouseX >  xStat + 320 && mouseX < xStat+360 && mouseY > yAssumption+60-20 && mouseY < yAssumption+60){
    fill(80,200);
    rect(xStat-350,yAssumption+44,320,56,7);
    fill(220);
    text("The reproduction number is the average number",xStat-340,yAssumption+68);
    text("of infections caused by one infectious agent.",xStat-340,yAssumption+88);
    }
    
    if(mouseX >  xStat && mouseX < xStat+150 && mouseY > yButton1-25 && mouseY < yButton1-10){
    fill(80,200);
    rect(xStat-350,yButton1-29,320,56,7);
    fill(220);
    text("Controls the proportion of infected agents in",xStat-340,yButton1-5);
    text("isolation and assumes 0% transmissability.",xStat-340,yButton1+15);
    }
    
    if(mouseX >  xStat && mouseX < xStat+150 && mouseY > yButton2-30 && mouseY < yButton2-25){
    fill(80,200);
    rect(xStat-350,yButton2-40,320,56,7);
    fill(220);
    text("Controls the proportion of agents who are",xStat-340,yButton2-15);
    text("immobile and assumes low transmissability.",xStat-340,yButton2+5);
    }
    
     if(mouseX >  xStat && mouseX < xStat+150 && mouseY > yButton3-50 && mouseY < yButton3-30){
    fill(80,200);
    rect(xStat-350,yButton3-55,320,56,7);
    fill(220);
    text("Controls the proportion of agents who come in",xStat-340,yButton3-30);
    text("contact with an infected agent and isolate.",xStat-340,yButton3-10);
    }
    
    if(mouseX >  xStat && mouseX < xStat+150 && mouseY > yButton3 && mouseY < yButton3+20){
    fill(80,200);
    rect(xStat-350,yButton3-17,320,56,7);
    fill(220);
    text("Controls the proportion of agents wearing ",xStat-340,yButton3+5);
    text("a face covering and assumes low transmissability.",xStat-340,yButton3+25);
    }
  
    
    if(mouseX >  xStat && mouseX < xStat+100 && mouseY > yDay-15 && mouseY < yDay){
    fill(80,200);
    rect(xStat-350,yDay-19,320,56,7);
    fill(220);
    text("The number of agents that are actively exposed",xStat-340,yDay+3);
    text("and are in their incubation period.",xStat-340,yDay+23);
    }
    
     if(mouseX >  xStat && mouseX < xStat+100 && mouseY > yInfect-15 && mouseY < yInfect){
    fill(80,200);
    rect(xStat-350,yInfect-19,320,56,7);
    fill(220);
    text("The number of agents that are actively infected",xStat-340,yInfect+3);
    text("and are in a contagious state.",xStat-340,yInfect+23);
    }
    
     if(mouseX >  xStat && mouseX < xStat+150 && mouseY > ySick-15 && mouseY < ySick){
    fill(80,200);
    rect(xStat-350,ySick-19,320,56,7);
    fill(220);
    text("The number of agents that are asymptomatic",xStat-340,ySick+3);
    text("and assumes a lower chance of transmission.",xStat-340,ySick+23);
    }
    
    if(mouseX > xStat + 250 && mouseX < xStat+360 && mouseY > yDay-15 && mouseY < yDay){
    fill(80,200);
    rect(xStat-350,yDay-19,320,56,7);
    fill(220);
    text("The total number of agents that have recovered",xStat-340,yDay+3);
    text("and are assumed to be immune to reinfection.",xStat-340,yDay+23);
    }
    
     if(mouseX > xStat + 290 && mouseX < xStat+360 && mouseY > yInfect-15 && mouseY < yInfect){
    fill(80,200);
    rect(xStat-350,yInfect-19,320,56,7);
    fill(220);
    text("The total number of agents that did not survive",xStat-340,yInfect+3);
    text("and have been removed from the simulation.",xStat-340,yInfect+23);
    }
    
     if(mouseX > xStat + 230 && mouseX < xStat+360 && mouseY > ySick-15 && mouseY < ySick){
    fill(80,200);
    rect(xStat-350,ySick-19,320,56,7);
    fill(220);
    text("The case fatality rate is the proportion of",xStat-340,ySick+3);
    text("affected agents that do not survive.",xStat-340,ySick+23);
    }
    
    //if(mouseX >  xStat && mouseX < xStat+360 && mouseY > yHealthy+5 && mouseY < yHealthy+45){
    //fill(80,200);
    //rect(xStat-350,yHealthy-13,320,56,7);
    //fill(220);
    //text("The prevalence bar shows the total proportion",xStat-340,yHealthy+10);
    //text("of agents that have been affected by the virus.",xStat-340,yHealthy+30);
    //}
    
    if(mouseX >  xStat && mouseX < xStat+360 && mouseY > yCFR-160 && mouseY < yCFR){
    fill(80,200);
    rect(xStat-350,yCFR-185,320,56,7);
    fill(220);
    text("The epidemic curve shows the active number of",xStat-340,yCFR-163);
    text("infected agents over time.",xStat-340,yCFR-143);
    }
    
    if(mouseX >  xStat && mouseX < xStat+360 && mouseY > yCFR-83 && mouseY < yCFR-77){
    fill(80,200);
    rect(xStat-350,yCFR-94,320,56,7);
    fill(220);
    text("This target line represents the theoretical",xStat-340,yCFR-72);
    text("healthcare systems maximum capacity.",xStat-340,yCFR-57);
    }
   
    
    
    fill(255);
    textAlign(LEFT);
    textFont(altFont);
    textSize(14);

    if(!isSetup){
     noStroke();
     fill(255);
     textAlign(CENTER);
     stroke(255);
     //strokeWeight(3);
     noFill();
     //ellipse(((width-420)/2)-20,((height-40)/2)-123,12,12);
    // ellipse(((width-420)/2)-85,((height-40)/2)-105,26,26);
     fill(255);
     virs.resize(0,110);
     hhi.resize(0,60);
     image(hhi,50,50);
     image(virs,((width-380)/2)-62,((height-40)/2)-150);
     
     //text("V",(width-420)/2,((height-40)/2)-75);
     textFont(altFont);
     textSize(18);
     if(!about){
     //virs.resize(0,120);
     //image(virs,((width-420)/2)-85,((height-40)/2)-220);
     text("START SIMULATION",(width-380)/2,((height-40)/2));
     text("ABOUT", (width-380)/2,((height-40)/2)+35);
     textAlign(RIGHT);
     //text("[BETA TESTING]",width-420,(65));
    // text("INFO ON COVID-19", (width-380)/2,((height-40)/2)+70);
     }
     if(about){

     textFont(altFont);
     textSize(14);
     text("The Visual Response Simulator | ViRS | is an agent-based modeling project designed to explore", (width-380)/2,((height-40)/2));
     text("and visualize how disease dynamics and social behaviors interact over space and time.",(width-380)/2,((height-40)/2)+20);
     text("Originating as an individual thesis project at the Harvard Graduate School of Design,", (width-380)/2,((height-40)/2)+40);
     text("ViRS is now a collaborative, cross-disciplinary research effort at the Harvard Humanitarian Initiative.", (width-380)/2,((height-40)/2)+60);
     
     text("This particular product from ViRS is a spatially abstract COVID-19 transmission study model.", (width-380)/2,((height-40)/2)+100);
     text("It intends to explore the potential level of impact non-pharmaceutical public health interventions", (width-380)/2,((height-40)/2)+120);
     text("have on containing and stopping a COVID-19 outbreak within a population of agents.", (width-380)/2,((height-40)/2)+140);
     
     text("This is not a prediction model. Its primary purpose is to act as an educational tool that", (width-380)/2,((height-40)/2)+180);
     text("gives the user the ability to control certain parameters and explore their effects on the outbreak.", (width-380)/2,((height-40)/2)+200);
     text("This model is in beta in its early stages and will be regularly updated with improvements.", (width-380)/2,((height-40)/2)+220);
     
     text("We'd love to hear your thoughts, please take our...", (width-380)/2,((height-40)/2)+260);
    
     textSize(18);
     text("USER FEEDBACK SURVEY", (width-380)/2,((height-40)/2)+290);
     text("BACK", (width-380)/2,((height-40)/2)+335);
     
      fill(255,50);
      noStroke();
      rect(((width-420)/2)-104,((height-40)/2)+270,248,27,7);
     }
     fill(255);
     dayCounter = 0;
    }
     // long t3 = System.currentTimeMillis();
   // println("the time after paragraph " + (t3-t2));
    
    textSize(14);
    textAlign(CENTER);
   // text(nf(percentAffected, 0, 2) + "%", xStat+xInfected+xSurvivors+xDead+xSick+10, yHealthy);
    
    textAlign(RIGHT);
    //textSize(17);
    text(int(popSize) +"  AGENTS", xStat+349, yAssumption);
    text(dayCounter+ " DAYS |"  + " CASES: " + nf(round(numSick+numHealed+numDead),3), xStat+360, yStats); 
    
    //textSize(14);
    text("FATALITY RATE: " + nf(percentCFR, 0, 2) + "%", xStat+360, ySick);
    
    text("RECOVERED: " + nf(int(numHealed),3), xStat+360, yDay);

    text("DEATHS: " + nf(int(numDead),3), xStat+360, yInfect);
    
    text("SUSCEPTIBILITY: "+ round(100-map(numHealed,0, 1000, 0, 100)) + "%" , xStat+360, yAssumption+35);
   
    text("R 0: 2", xStat+360, yAssumption+60);

    textAlign(LEFT);
    
    text("INCUBATION: 4-6 DAYS" , xStat, yAssumption+35);
    
    text("INFECTIOUS: 3-7 DAYS" , xStat, yAssumption+60);

    text("INFECTIOUS: " + int(numSick), xStat+18, yInfect);
    
    text("EPIDEMIC CURVE ", xStat, (ySick-yInfect)+ySick+10);

    text("EXPOSED: " + int(numInfected), xStat+18, yDay);

    text("INFECTIOUS IN ISOLATION", xStat, yButton1-10);
    
    text("SOCIAL DISTANCING", xStat, yButton2-25);
    
    text("CONTACTS TRACED", xStat+16, yButton3-40);
    
    text("FACE COVERING", xStat+18, yButton3+10);
    
    text("PREVALENCE: "+nf(percentAffected, 0, 2) + "%", xStat, ySick);
    
   // text("USER FEEDBACK", xStat, yTitle+21);
   
    textSize(16);
    fill(255);
    
    text("ASSUMPTIONS", xStat, yAssumption);

    text("INTERVENTIONS", xStat, yButton1-45);
    
    text("RESULTS", xStat, yStats);

    fill(255);

    textSize(23);
    
    text("COVID-19 SIMULATOR", xStat, yTitle+2);
 
    stroke(255);
    strokeWeight(1);
    noFill();
 //   rect(xStat+256,yTitle-16,38,19, 4);
    if(!isSetup){
    fill(180);
    }
    rect(xStat+340,yTitle-16,20,19, 4);
    
    textSize(14);
    fill(255);
    text("| BETA", xStat+250, yTitle-4);
    if(!isSetup){
      fill(0);
    }
    text("M", xStat+345, yTitle-1);
    
    
    fill(255, 255, 0); 
    noStroke();
    ellipse( xStat+5, yDay-5, 5, 5);
    //strokeWeight(1);
    //noFill();
    //stroke(255, 255, 0, 100);
    //ellipse(xStat+5, yDay-5, 13, 13);
    
    fill(238, 90, 30); 
    noStroke();
    ellipse( xStat+5, yInfect-5, 5, 5);
    strokeWeight(1);
    noFill();
    stroke(238, 90, 30);
    ellipse(xStat+5, yInfect-5, 13, 13);
    
    fill(255); 
    noStroke();
  //  ellipse( xStat+5, yButton3-15, 4, 4);
  
  ///the ellipse for Contacts Traced 
    strokeWeight(1);
    noFill();
    fill(#E82A2A); 
    ellipse(xStat+6, yButton3-44, 9, 9);
    
    
    //// the ellipse for face covering
    strokeWeight(1);
    noFill();
    stroke(62,214,43); 
    ellipse(xStat+7, yButton3+5, 9,9);
    
    
    fill(88, 150, 255); 
    noStroke();
    ellipse( xStat+230, yDay-5, 5, 5);
    
    fill(255); 
    noStroke();
    ellipse( xStat+358, yAssumption-5, 4, 4);

    textAlign(CENTER);
    textFont(altFont);
    textSize(20);

    fill(255, 255, 255);
    
 
    //float xCFR = map(percentCFR, 0, xScale, 0, 360);

       textAlign(CENTER);
       textSize(15);
       noFill();
       stroke(255);
       strokeWeight(1);
       if(s1){
         fill(180);
       }
       rect(xStat,yButton1,65,15, 7);
       fill(0);
       if(!s1){
       fill(200);
       }
       
       text("0%", xStat+34,yPercent-8);
       
       noFill();
       if(s2){
         fill(180);
       }
       rect(xStat+74,yButton1,65,15, 7);
       fill(0);
       if(!s2){
       fill(200);
       }
       
       text("25%", xStat+109,yPercent-8);
       
       noFill();
       if(s3){
         fill(180);
       }
       rect(xStat+149,yButton1,65,15, 7);
       fill(0);
       if(!s3){
       fill(200);
       }
       
       text("50%", xStat+184,yPercent-8);
       
       noFill();
       if(s4){
         fill(180);
       }
       rect(xStat+223,yButton1,65,15, 7);
       fill(0);
       if(!s4){
       fill(200);
       }
       
       text("75%", xStat+259,yPercent-8);
       noFill();
       
       noFill();
       if(s5){
         fill(180);
       }
       rect(xStat+297,yButton1,65,15, 7);
       fill(0);
       if(!s5){
       fill(200);
       }
       
       text("100%", xStat+329,yPercent-8);
       noFill();
      
       if(su1){
         fill(180);
       }
       rect(xStat,yButton2-20,65,15,7);
       fill(0);
       if(!su1){
       fill(200);
       }
       
       text("0%", xStat+34,yPercent2-27);
       
       noFill();
       if(su2){
         fill(180);
       }
       rect(xStat+74,yButton2-20,65,15, 7);
       fill(0);
       if(!su2){
       fill(200);
       }
       
       text("25%", xStat+109,yPercent2-27);
       
       noFill();
       if(su3){
         fill(180);
       }
       rect(xStat+149,yButton2-20,65,15, 7);
       fill(0);
       if(!su3){
       fill(200);
       }
       
       text("50%", xStat+184,yPercent2-27);
       
       noFill();
       if(su4){
         fill(180);
       }
       rect(xStat+223,yButton2-20,65,15, 7);
       fill(0);
       if(!su4){
       fill(200);
       }
       
       text("75%", xStat+259,yPercent2-27);
       noFill();
       
       noFill();
       if(su5){
         fill(180);
       }
       rect(xStat+297,yButton2-20,65,15, 7);
       fill(0);
       if(!su5){
       fill(200);
       }
       
       text("100%", xStat+329,yPercent2-27);
       
       
       noFill();
      
       if(ct1){
         fill(180);
       }
       rect(xStat,yButton3-30,65,15, 7);
       fill(0);
       if(!ct1){
       fill(200);
       }
       
       text("0%", xStat+34,yPercent3-37);
       
       noFill();
       if(ct2){
         fill(180);
       }
       rect(xStat+74,yButton3-30,65,15, 7);
       fill(0);
       if(!ct2){
       fill(200);
       }
       
       text("25%", xStat+109,yPercent3-37);
       
       noFill();
       if(ct3){
         fill(180);
       }
       rect(xStat+149,yButton3-30,65,15, 7);
       fill(0);
       if(!ct3){
       fill(200);
       }
       
       text("50%", xStat+184,yPercent3-37);
       
       noFill();
       if(ct4){
         fill(180);
       }
       rect(xStat+223,yButton3-30,65,15, 7);
       fill(0);
       if(!ct4){
       fill(200);
       }
       
       text("75%", xStat+259,yPercent3-37);
       noFill();
       
       noFill();
       if(ct5){
         fill(180);
       }
       rect(xStat+297,yButton3-30,65,15, 7);
       fill(0);
       if(!ct5){
       fill(200);
       }
       
       text("100%", xStat+329,yPercent3-37);
    noFill();
    
    if(a1){
         fill(180);
       }
       rect(xStat,yButton3+20,65,15, 7);
       fill(0);
       if(!a1){
       fill(200);
       }
       
       text("0%", xStat+34,yPercent3+13);
       
       noFill();
       if(a2){
         fill(180);
       }
       rect(xStat+74,yButton3+20,65,15, 7);
       fill(0);
       if(!a2){
       fill(200);
       }
       
       text("25%", xStat+109,yPercent3+13);
       
       noFill();
       if(a3){
         fill(180);
       }
       rect(xStat+149,yButton3+20,65,15, 7);
       fill(0);
       if(!a3){
       fill(200);
       }
       
       text("50%", xStat+184,yPercent3+13);
       
       noFill();
       if(a4){
         fill(180);
       }
       rect(xStat+223,yButton3+20,65,15, 7);
       fill(0);
       if(!a4){
       fill(200);
       }
       
       text("75%", xStat+259,yPercent3+13);
       noFill();
       
       noFill();
       if(a5){
         fill(180);
       }
       rect(xStat+297,yButton3+20,65,15, 7);
       fill(0);
       if(!a5){
       fill(200);
       }
       
       text("100%", xStat+329,yPercent3+13);
    noStroke();

    fill(25);

    //rect(xStat, yHealthy + 10, 360, 35,7);
    
    rect(xStat, yCFR, 360, -160);

    fill(238, 109, 3, 150);

    //rect(xStat+xInfected+xSurvivors+xDead, yHealthy + 10, xSick, 35);

    //fill(255, 255, 0, 150);

    //rect(xStat+xSurvivors+xDead, yHealthy + 10, xInfected, 35);

    //fill(88, 150, 255,150); 

    //rect(xStat+xDead, yHealthy + 10, xSurvivors, 35);;

    //fill(138, 43, 226, 100);

    //rect(xStat, yHealthy + 10, xDead, 35);
    ////////////////////////////////////////////////////////////////////// EPIDEMIC CURVE
    fill(255,100);
    sickHistory.put(((sickHistory.size())+1),yCFR-(numSick));
     
    strokeWeight(2);
    int yLine = 713 - 80;
    
     if (numSick >= 159 && numSick < 299) { 
        adjust = true; 
        
    } 
       if (numSick >= 300) { 
        adjust2 = true; 
    }
     if(adjust){
    yLine = 713 -25;
    }
    
    if (adjust2) { 
        yLine = 713 - 13;
    } 
    
    strokeWeight(1);
    stroke(153);
    line(xStat,yLine,xStat+360,yLine);

    if (isSetup){
    xCord1 = 740;
   
    for (int i = 0; i < frameCount; i++) 
    {
    if ( i < sickHistory.size() && sickHistory.get(i) != null){
    float yInfected = sickHistory.get(i);
    
    if (numSick >= 159 && numSick < 299) { 
        adjust = true; 
        
    } 
    
    if (numSick >= 300) { 
        adjust2 = true; 
    } 
    
     
    if(adjust){
    yInfected   = (yInfected+yCFR)/2;
    yLine = 713 -25;
    }
    
    if (adjust2) { 
        yInfected   = (yInfected+yCFR)/2; 
        yLine = 713 - 13;
    } 
    
   strokeWeight(1);

    stroke(100,10);
    noFill();
    stroke(238, 109, 3, 30);
    line(xCord1, yInfected, xCord1, yCFR);
    xCord1 = xCord1 + .06;
     }
    
    }
    
    }

    
  if(!isSetup){
    strokeWeight(1);
    stroke(155,90);
    line(xStat,yLine,xStat+360,yLine); 
    }
    
    
   // line(xStat+xInfected+xSurvivors+xDead+xSick, yHealthy+8,xStat+xInfected+xSurvivors+xDead+xSick,yHealthy+45);
    
   if ((numSick == 0 && numInfected == 0 && dayCounter > 9) || dayCounter > 99) {
     
     fill(0,100);
     noStroke();
     rect(20,20,width-420,700,7); 
     
     fill(250);
     textSize(18);
     text("SIMULATION OVER", (width-380)/2,((height-40)/2));
     text("REFRESH BROWSER TO RETURN TO MAIN MENU", (width-380)/2,((height-40)/2)+35);
     //text("USER FEEDBACK SURVEY", (width-380)/2,((height-40)/2)+70);
    
     //fill(255,100);
     //noStroke();
     //rect(((width-420)/2)-104,((height-40)/2)+50,248,27,7);
    
     over = true;

    if (looping) {
      noLoop();
    } else {
      loop();
    }

  }
   

  
   
  //  println("at the end of statsbar" + (t7-t6));
}
/////////////////////////////////////////////////////////////////////////// Infect

void infect()

{
  
  if(ct1){
        isolationProb = 0.0;
      }
   if(ct2){
        isolationProb = 0.007;
      }
      if(ct3){
        isolationProb = 0.01;
      }
      if(ct4){
        isolationProb = .015;
      }
      if(ct5){
        isolationProb = 1.0;
      }
      
      

     
      for (int i = 0; i < sickAgents.size(); i += 1) {
  
          Agent person1 = sickAgents.get(i);
         
            if(person1.sick){
        for (int j = i + 1; j < population.size(); j += 1)

        {
            Agent person2 = population.get(j);
             if (( !person2.sick && !person1.recovered)){
            
            float distance = dist(person1.loc.x, person1.loc.y, person2.loc.x, person2.loc.y);

            // first condition

            if (distance <= spreadDistance && person1.sick && !person2.sick && !person2.recovered  && !person1.sickIsolate)

            {
              
              if(person2.socialDistance){
                
                infectionProbability = .06;
                
              }
              
              if (person2.wearingMask && !person1.wearingMask){
                infectionProbability = .08;
              }
              
               if (person2.wearingMask && person1.wearingMask){
                infectionProbability = .02;
              }
              
              if (!person2.wearingMask && person1.wearingMask){
                infectionProbability = .04;
              }
              

                if (prob(infectionProbability) && !person1.isolate) {

                    person2.getInfected();
                    sickAgents.add(person2);
                }


            } 
            //else if (distance <= spreadDistance && person2.sick && !person1.sick && !person1.recovered && !person2.sickIsolate)

            //{
              
            //    if(person1.socialDistance){
                
            //    infectionProbability = .06;
                
            //  }
              
            //  if (person2.wearingMask && !person1.wearingMask){
            //    infectionProbability = .04;
            //  }
              
            //   if (person2.wearingMask && person1.wearingMask){
            //    infectionProbability = .02;
            //  }
              
            //  if (!person2.wearingMask && person1.wearingMask){
            //    infectionProbability = .08;
            //  }

            //    if (prob(infectionProbability) && !person2.isolate) {

            //        person1.getInfected(); 
            //        sickAgents.add(person1);
                  
            //    }
                
            //}              
            
            infectionLine(person1,person2);
            
            if (distance <= contactDistance && person1.sick && !person2.sick && !person2.recovered )

            {

                if (prob(isolationProb)) {

                    person2.getTraced(); 
                }


            } else if (distance <= contactDistance && person2.sick && !person1.sick && !person1.recovered )

            {
                
                if (prob(isolationProb)) {

                    person1.getTraced(); 
                }           
             }       
          }

    }
    }
      }
    }
    


///////////////////////////////////////////////////////////////////////Probability Rate

boolean prob(float probRate)

{

    if (random(0, 1) <= probRate) {

        return true;

    } else {

        return false;

    }

}

/////////////////////////////////////////////////////////////////////// Initailize Pop

void initailizePop() {

    population = new ArrayList < Agent > ();

    for (int i = 0; i < initialPopulationSize; i += 1)

    {

        PVector L = new PVector(random(25, width - 407), random(27, height-26));        

        population.add(new Agent(L));

    }
    
}
    
void infectionLine(Agent person1, Agent person2) {
  
  float spreadDist = dist(person1.loc.x, person1.loc.y, person2.loc.x, person2.loc.y);

      if (spreadDist < 20){

        stroke(255,70);

        strokeWeight(3);
        
        if((person1.vel.x == 0 || person2.vel.x == 0)){//??
        noStroke();//??
     }
        line(person1.loc.x, person1.loc.y, person2.loc.x, person2.loc.y);
      }
       
}



void infectedAgent(){
  
  PVector L = new PVector(random(0, width - 400), random(0, height));

    Agent infectedPerson = new Agent(L);

    infectedPerson.getInfected();

    infectedPerson.loc.x = (width-400)/2;

    infectedPerson.loc.y = (height-180)/2;

    population.add(infectedPerson);
 
}

////////////////////////////////////////////////////////////////////////////////Pop Flux

void popFlux()

{

    int numberToFlux = round(popFluxRate * currentPopulationSize);

    PVector H = new PVector(random(0, width), random(0, height - 35));

    while (numberToFlux > 0)

    {

        Agent parent = population.get((int) random(population.size()));

        Agent child = new Agent(H);

        // Child gets velocity from "parent" rather than

        // having it randomly assigned.

        child.vel = new PVector(parent.vel.x, parent.vel.y);

        population.add(child);

        numberToFlux -= 1;

    }
 
}

//============================================================//

void mousePressed()

{

    PVector L = new PVector(random(0, width - 400), random(0, height));

    Agent infectedPerson = new Agent(L);

    infectedPerson.getInfected();
    if(mouseX<width-400 && mouseX> width- 1095 && mouseY<height-30 && mouseY> height - 720 && !over){
    if(mouseX >= ((width-400)/2)-90 && mouseX <= ((width-400)/2)+90 && mouseY >= ((height-40)/2)-15 && mouseY <= ((height-40)/2)){
    if(!isSetup){
            //adjust = false;
            //adjust2 = false;
            isSetup = true;
            population.clear();

        for (int i = 0; i < initialPopulationSize; i += 1)

        { 
            PVector R = new PVector(random(28, width - 408), random(28, height-28));
            population.add(new Agent(R));
            
            dayCounter = 0;
            numDead = 0;
            xCord1 = 0;
        }
        
        sickHistory.clear();
        
      }
    }

    if(isSetup && population.size() < 1020){
    infectedPerson.loc.x = mouseX;

    infectedPerson.loc.y = mouseY;

    population.add(infectedPerson);
    sickAgents.add(infectedPerson);
    }

    loop();
    }
 

    //text("INSTRUCTIONS", (width-420)/2,((height-40)/2)-05);
    if(!isSetup){
    if (mouseX > 50 && mouseX < 200 && mouseY > 50 && mouseY < 120) { 
    link("https://hhi.harvard.edu/");
  }

  if ((mouseX > ((width-380)/2)-110 && mouseX < ((width-380)/2)+110 && mouseY > ((height-40)/2)+270 && mouseY < ((height-40)/2)+290) && about) { 
    link("http://virs.io/survey/");
  }
 }
        
    if(mouseX >= ((width-420)/2)-30 && mouseX <= ((width-420)/2)+30 && mouseY >= ((height-40)/2)+20 && mouseY <= ((height-40)/2)+35){
      if(!about){
       about = true; 
      }
    }
    
    if(mouseX >= ((width-420)/2)-30 && mouseX <= ((width-420)/2)+30 && mouseY >= ((height-40)/2)+325 && mouseY <= ((height-40)/2)+335){
      if(about){
       about = false; 
    }
    }
    
    if(mouseX >= xStat+335 && mouseX <= (xStat+355) && mouseY >= 25 && mouseY <= (45)){
      
      isSetup = false;
      over = false;
      population.clear();
      
      for (int i = 0; i < initialPopulationSize; i += 1)

        { 
           // PVector R = new PVector(random(27, width - 406), random(25, height-26));
            population.add(new Agent(L));
            dayCounter = 0;
            numDead = 0;
            xCord1 = 0;
        }
        
        sickHistory.clear();
        
        if(!looping){
          loop();
        } 
        
        s1 = true;
        s2 = false;
        s3 = false;
        s4 = false;
        s5 = false;

        su1 = true;
        su2 = false;
        su3 = false;
        su4 = false;
        su5 = false;

        ct1 = true;
        ct2 = false;
        ct3 = false;
        ct4 = false;
        ct5 = false;

        a1 = true;
        a2 = false;
        a3 = false; 
        a4 = false; 
        a5 = false;

    }

   if(mouseX >= xStat && mouseX <= (xStat+65) && mouseY >= yButton1 && mouseY <= (yButton1+15)){
      s1 = true;
      s2 = false;
      s3 = false;
      s4 = false;
      s5 = false;
    }
    
    if(mouseX >= xStat+74 && mouseX <= (xStat+139) && mouseY >= yButton1 && mouseY <= (yButton1+15)){
      s1 = false;
      s2 = true;
      s3 = false;
      s4 = false;
      s5 = false;
    }
    
    if(mouseX >= xStat+149 && mouseX <= (xStat+214) && mouseY >= yButton1 && mouseY <= (yButton1+15)){
      s1 = false;
      s2 = false;
      s3 = true;
      s4 = false;
      s5 = false;
    }
    
    if(mouseX >= xStat+223 && mouseX <= (xStat+288) && mouseY >= yButton1 && mouseY <= (yButton1+15)){
      s1 = false;
      s2 = false;
      s3 = false;
      s4 = true;
      s5 = false;
    }
    
    if(mouseX >= xStat+297 && mouseX <= (xStat+362) && mouseY >= yButton1 && mouseY <= (yButton1+15)){
      s1 = false;
      s2 = false;
      s3 = false;
      s4 = false;
      s5 = true;
    }

    
    if(mouseX >= xStat && mouseX <= (xStat+65) && mouseY >= yButton2-15 && mouseY <= (yButton2-4)){
      su1 = true;
      su2 = false;
      su3 = false;
      su4 = false;
      su5 = false;
    }
    
    if(mouseX >= xStat+74 && mouseX <= (xStat+139) && mouseY >= yButton2-15 && mouseY <= (yButton2-4)){
      su1 = false;
      su2 = true;
      su3 = false;
      su4 = false;
      su5 = false;
    }
    
    if(mouseX >= xStat+149 && mouseX <= (xStat+214) && mouseY >= yButton2-15 && mouseY <= (yButton2-4)){
      su1 = false;
      su2 = false;
      su3 = true;
      su4 = false;
      su5 = false;
    }
    if(mouseX >= xStat+223 && mouseX <= (xStat+288) && mouseY >= yButton2-15 && mouseY <= (yButton2-4)){
      su1 = false;
      su2 = false;
      su3 = false;
      su4 = true;
      su5 = false;
    }
    if(mouseX >= xStat+297 && mouseX <= (xStat+362) && mouseY >= yButton2-15 && mouseY <= (yButton2-4)){
      su1 = false;
      su2 = false;
      su3 = false;
      su4 = false;
      su5 = true;
    }
    
    if(mouseX >= xStat && mouseX <= (xStat+65) && mouseY >= yButton3-30 && mouseY <= (yButton3-15)){
      ct1 = true;
      ct2 = false;
      ct3 = false;
      ct4 = false;
      ct5 = false;
    }
    
    if(mouseX >= xStat+74 && mouseX <= (xStat+139) && mouseY >= yButton3-30 && mouseY <= (yButton3-15)){
      ct1 = false;
      ct2 = true;
      ct3 = false;
      ct4 = false;
      ct5 = false;
    }
    
    if(mouseX >= xStat+149 && mouseX <= (xStat+214) && mouseY >= yButton3-30 && mouseY <= (yButton3-15)){
      ct1 = false;
      ct2 = false;
      ct3 = true;
      ct4 = false;
      ct5 = false;
    }
    if(mouseX >= xStat+223 && mouseX <= (xStat+288) && mouseY >= yButton3-30 && mouseY <= (yButton3-15)){
      ct1 = false;
      ct2 = false;
      ct3 = false;
      ct4 = true;
      ct5 = false;
    }
    if(mouseX >= xStat+297 && mouseX <= (xStat+362) && mouseY >= yButton3-30 && mouseY <= (yButton3-15)){
      ct1 = false;
      ct2 = false;
      ct3 = false;
      ct4 = false;
      ct5 = true;
    }
    
    if(mouseX >= xStat && mouseX <= (xStat+65) && mouseY >= yButton3+20 && mouseY <= (yButton3+35)){
      a1 = true;
      a2 = false;
      a3 = false;
      a4 = false;
      a5 = false;
    }
    
    if(mouseX >= xStat+74 && mouseX <= (xStat+139) && mouseY >= yButton3+20 && mouseY <= (yButton3+35)){
      a1 = false;
      a2 = true;
      a3 = false;
      a4 = false;
      a5 = false;
    }
    
    if(mouseX >= xStat+149 && mouseX <= (xStat+214) && mouseY >= yButton3+20 && mouseY <= (yButton3+35)){
      a1 = false;
      a2 = false;
      a3 = true;
      a4 = false;
      a5 = false;
    }
    
    if(mouseX >= xStat+223 && mouseX <= (xStat+288) && mouseY >= yButton3+20 && mouseY <= (yButton3+35)){
      a1 = false;
      a2 = false;
      a3 = false;
      a4 = true;
      a5 = false;
    }
    if(mouseX >= xStat+297 && mouseX <= (xStat+362) && mouseY >= yButton3+20 && mouseY <= (yButton3+35)){
      a1 = false;
      a2 = false;
      a3 = false;
      a4 = false;
      a5 = true;
    }
     
}

////////////////////////////////////////////////////////////////////////////////// Reset

void keyPressed()

{


    if (key == ' ') {
       pause = !pause;
      
      if(pause){
      noLoop();
      }
      else {
        loop();
      }

   }
     
    
}

class Agent {

  PVector loc;

  PVector vel;
  
  PVector noVel;

  PVector accel;

  float topspeed;

  boolean dead = false;

  boolean sick = false;

  boolean recovered = false;

  boolean infected = false;

  int haloGrowth = 0;
  
  float deathRate = 0.028;

  PVector target;

  int rad;

  int perHealthy = 100;

  int days = 0;

  float t = frameCount;
  
  float randomNum = random(0, 1);

  float sickIsolateRate;
  
  float travelIsolate;
  
  float maskTransmissionRate;
  
  boolean sickIsolate = false;
  
  boolean wearingMask = false;
  
  boolean socialDistance = false;
  
  boolean susceptible = true;
  
  boolean isolate = false;
  
  boolean isolateDone = false;
  
  boolean traced = false;
  
  int d = frameCount;
  
  int delay = frameCount;
  

  Agent(PVector L)

  {

    loc = L;

    vel = new PVector(random(-1,1), random(-1, 1));

    noVel = new PVector(0, 0);
    
    topspeed = 2;

    accel = new PVector(0, 0);

    target = new PVector(random(width), random(height));

    if (random(0, 100) < perHealthy) { 

      sick = false;
      susceptible = true;

    }
    
    else{
     susceptible = false;
     recovered = true;
    }

  }

  void update()

  {    

    if ( frameCount%framesPerDay == 0 && sick)

    {

      days -=1;

      if (days == 0){ 
        if(randomNum > deathRate){
         survive();
      }
      else {
      dead = true; 
         
      }
    }
   }
    
    if (infected)

    { 

      t += 1;

      if (t >= random(240,360)) {    

        getSick(minDays, maxDays);

      }

  }
  
  if (traced)
    { 
      delay += 1;
      if (delay >= random(60,120)) {    
        getIsolated();
      }
  }
  
    if(socialDistance){ 
    loc.add(noVel);
    }
    
    if(!socialDistance) {
    loc.add(vel);
    }  
    
    bounce();
    drawAgent();
    
    if (isolate)
    {      
      if(frameCount % 60 == 0){
      d += 1;
      if (d >= 10) {    
        isolate = false;
        doneIsolate();
      }
    }
  }
  
}

void survive()
{
  if (sick){
      sick = false;
      infected = false;
      recovered = true;
      if (recovered && sickIsolate){
         vel = new PVector(random(-1,1), random(-1, 1));
  }
 }
}


void doneIsolate(){
    isolateDone = true;
    vel = new PVector(random(-1,1), random(-1, 1));
}

void dead()
{
 sick = false; 
 recovered = false;
 dead = true;
}

////////////////////////////////////////////////////////////////////////// DrawAgent Function

void drawAgent()
  {   
    if (susceptible){
      dead = false;
      fill(255); 
      rad = 4;
    }

    if(su1){
        travelIsolate = 0.0;
      }
      if(su2){
        travelIsolate = 0.25;
      }
      if(su3){
        travelIsolate = 0.50;
      }
      if(su4){
        travelIsolate = .75;
      }
      if(su5){
        travelIsolate = 1.0;
      }
      
      if (susceptible || infected || sick || recovered){
        if (randomNum < travelIsolate){
         socialDistance = true;
      }
      else { socialDistance = false; }
    }
    
      if(a1){
        maskTransmissionRate = 0.0;
      }
      if(a2){
        maskTransmissionRate = 0.25;
      }
      if(a3){
        maskTransmissionRate = 0.5;
      }
      if(a4){
        maskTransmissionRate = 0.75;
      }
      if(a5){
        maskTransmissionRate = 1;
      }
      if (randomNum < maskTransmissionRate){
        wearingMask = true;     
    }
    else{
      wearingMask = false;
    }
    
    
    

    if ( sick ) {
      fill(238, 90, 30);
      susceptible = false;
      rad = 5;
      if(s1){
        sickIsolateRate = 0.0;
      }
      if(s2){
        sickIsolateRate = 0.25;
      }
      if(s3){
        sickIsolateRate = 0.5;
      }
      if(s4){
        sickIsolateRate = 0.75;
      }
      if(s5){
        sickIsolateRate = 1;
      }
      if (randomNum < sickIsolateRate){
        sickIsolate = true;
        vel = new PVector(0, 0);
      }
      
     
    }

    if (infected) {
      susceptible = false;
      fill(255, 255, 0); 
      rad = 5 ;
    } 

    if (recovered) {
      susceptible = false;
      fill(88, 150, 255); 
      rad = 5;
    }
    
    if (dead) {
      susceptible = false;
      noFill();
      vel = new PVector(0,0);
      rad = 0;
    }
    
    noStroke();
    ellipse( loc.x, loc.y, rad, rad);
   

   if (isolate) {
      vel = new PVector(0, 0);  
    }

    //add Halos
    strokeWeight(1);
    noFill();

    if ( sick ) {
      if(!wearingMask){
      noFill();
      stroke(238, 90, 30);
      ellipse(loc.x, loc.y, 13, 13);
      }
    }

    //if (infected) {
    //  stroke(255, 255, 0, 100);
    //  ellipse(loc.x, loc.y, 13, 13);
    //}
    
    if (isolate) {
      fill(#E82A2A);
      //stroke(#E82A2A);
      ellipse(loc.x, loc.y, 5, 5);
    } 
    
      if (wearingMask){
        strokeWeight(1);
       stroke(62,214,43); 
       ellipse( loc.x, loc.y, 8, 8);
    }
  }

  void getInfected()
  {
    if(recovered == false){
    infected = true;
    t = 0;
    }
  }
  
  void getTraced()
  {
    if(!recovered){
    traced = true;
    delay = 0;
    }
  }
  
  void getIsolated()
  {
    isolate = true;
    traced = false;
    d = 0;
    wearingMask= false;
  }
  
  void wearMask()
  {
    wearingMask = true; 

  }
    

  void getSick(int minDay, int maxDay)
  {
    sick = true;
    infected = false;
    days = (int)random(minDay, maxDay);
  }

  void bounce()
  {
    if (loc.x < 28 || loc.x >= width-407) {
      vel.x *= -1;
    }
    if (loc.y < 30 || loc.y >= height-26) {
      vel.y *= -1;
    }
  }

}// End of Class
