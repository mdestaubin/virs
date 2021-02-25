int initialPopulationSize;
int clicks = 0; 

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

PImage thoPop;

PImage tenthoPop;
PImage InOut;
PImage Out;

//Winter 2021
//Declaring Images
PImage Pfizer; 
PImage Moderna;
PImage Oxford; 
PImage Johnson; 



//////////////////////// infection variables

int minDays = 3;

int maxDays = 7;

int spreadDistance = 5;

int contactDistance = 15;

float infectionProbability = .1;

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

 float  yCFR = 713;

boolean isSetup = false;



int numDead = 0;

int total; 

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

boolean b1 = true;
boolean b2 = false;
boolean b3 = false; 
boolean b4 = false; 
boolean b5 = false;


boolean c1 = true; 
boolean c2 = false; 
boolean c3 = false; 
boolean c4 = false; 
boolean c5 = false; 

boolean home = true; 

//Winter 2021
//Creating boolean variables
//boolean variables for selection screens
boolean popselection = false; 
boolean efficasySelection = false;
//boolean varibles for different senario modes
boolean pfizer = false; 
boolean moderna = false; 
boolean oxford = false;
boolean johnson = false; 
//boolean variables for different population mode 
boolean pop1 = false;
boolean pop2 = false; 


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
boolean adjust3 = false;
boolean adjust4 = false;
boolean adjust5 = false; 
boolean adjust6 = false; 
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
    thoPop = loadImage("DATA/1000.png");
    tenthoPop = loadImage("DATA/10000.png");
    InOut = loadImage("DATA/scenario2.png");
    Out = loadImage("DATA/scenario1.png");
//Winter 2021
//Declaring the imaes
    Pfizer = loadImage("DATA/Pfizer.png");
    Moderna = loadImage("DATA/moderna.png");
    Oxford = loadImage("DATA/Oxford.png");
    Johnson = loadImage("Data/johnson.png");
    
}

void draw()

{
    background(38,38,38);
    fill(38,38,38);
    stroke(255);
    strokeWeight(2);
    //println(frameRate);
   rect(20,20,width-420,700,6); 
    stroke(150);
    line(xStat,yAssumption-5,xStat+360,yAssumption-5);
    line(xStat,yButton1-69,xStat+360,yButton1-69);
    line(xStat,yStats-30,xStat+360,yStats-30);
    
    
    if(pop1 && !pop2){
    initialPopulationSize = 999;
    }
    if(pop2 && !pop1){
    initialPopulationSize = 9999;
    }

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
    vaccinate();
    infect();
    statsBar();
    //if(isSetup && frameCount % 2 == 0){
    //  saveFrame("output/#####.png");
    //}
    
}

void removeAgent() {
  for (int i = sickAgents.size() - 1; i >= 0; i--) {
          Agent d = sickAgents.get(i);
        if (d.dead == true) {
          sickAgents.remove(i);
          noStroke();
          fill(138, 43, 226,100);
          ellipse( d.loc.x, d.loc.y, 16, 16);
          numDead  += 1;
        
     } 
    }
    //for (int i = sickAgents.size() - 1; i >= 0; i--) {
    //      Agent d = sickAgents.get(i);
    //     if (d.dead == true) {
    //      sickAgents.remove(i); 
          
    // } 
    //}
    
   }
//Winter 2021
// craeting a method for vaccination
// the agents get vaccinated from this method
void vaccinate(){
  
  if (isSetup &&!home && !popselection && !efficasySelection ){
  int c =0;
  if (frameCount % framesPerDay == 0){
  
  for(Agent person: population){
    
    if(person.dead == false && person.recovered == false && person.infected == false && person.sick == false && !person.vaccinatedfirst &&!person.vaccinatedsecond){
    //  if (c1){
    //   if(c<=initialPopulationSize*0.000){
    //  person.getVaccinated();
    //  c +=1;
    //} 
    //  }
    if(pfizer || moderna || oxford ){
      if (c2){
      if(c<=initialPopulationSize*0.003){
      person.getVaccinated();
      c +=1;
      }
      }
      if (c3){
      if(c<=initialPopulationSize*0.006){
      person.getVaccinated();
      c +=1;
      }
      }
      if (c4){
      if(c<=initialPopulationSize*0.09){
      person.getVaccinated();
      c +=1;
      }
      }
      if (c5){
      if(c<=initialPopulationSize*0.012){
      person.getVaccinated();
      c +=1;
      }
      }
  }
    if(johnson){
     if (c2){
      if(c<=initialPopulationSize*0.003){
      person.getVaccintedtwice();
      c +=1;
      }
      }
      if (c3){
      if(c<=initialPopulationSize*0.006){
      person.getVaccintedtwice();
      c +=1;
      }
      }
      if (c4){
      if(c<=initialPopulationSize*0.09){
      person.getVaccintedtwice();
      c +=1;
      }
      }
      if (c5){
      if(c<=initialPopulationSize*0.012){
      person.getVaccintedtwice();
      c +=1;
      }
      }
  }
  }
  }

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
    float firstvacc = 0;
    float secondvacc= 0;
    
    for (Agent person: sickAgents) {

        if (person.sick == true) {

            numSick += 1;

        }
         if (person.infected == true) {

            numInfected += 1;

        }
         if (person.recovered == true && !person.vaccinatedfirst) {

            numHealed += 1;

        }
         if (person.dead == false && person.recovered == false && person.infected == false && person.sick == false) {
            numHealthy += 1;
        }
        
    

    }
    for(Agent person: population){
       if (person.vaccinatedfirst ==true){
           firstvacc +=1;
       }
       if (person.vaccinatedsecond ==true){
           secondvacc +=1;
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
     if(!about && !popselection && !efficasySelection){
     virs.resize(0,110);
     hhi.resize(0,60);
     image(hhi,50,50);
     image(virs,((width-380)/2)-62,((height-40)/2)-150);
     }
     if(about){
     virs.resize(0,110);
     hhi.resize(0,60);
     image(hhi,50,50);
     image(virs,((width-380)/2)-62,((height-40)/2)-200);
     }
     
     //text("V",(width-420)/2,((height-40)/2)-75);
     textFont(altFont);
     textSize(18);
     if(!about && !popselection && !efficasySelection){
     //virs.resize(0,120);
     //image(virs,((width-420)/2)-85,((height-40)/2)-220);
     text("START SIMULATION",(width-380)/2,((height-40)/2));
     text("ABOUT", (width-380)/2,((height-40)/2)+35);
     textAlign(RIGHT);
     //text("[BETA TESTING]",width-420,(65));
    // text("INFO ON COVID-19", (width-380)/2,((height-40)/2)+70);
     }
     
     if(popselection && !efficasySelection && !home){
       
     textFont(altFont);
     textSize(17);
    // text("SET AGENT POPULATION SIZE",(width-380)/2,((height-40)/2));
     textAlign(LEFT);
     thoPop.resize(0,332);
     image(thoPop,35,35);
     text("1,000 AGENTS",45,60);
     
     tenthoPop.resize(0,332);
     image(tenthoPop,35,375);
     text("10,000 AGENTS", 45 ,400);
     noFill();
     //rect(240,448,65,20, 5);
     //rect(340,448,65,20, 5);
     //rect(440,448,65,20, 5);
     }
     
     if(efficasySelection && !popselection){
       textAlign(LEFT);
     textFont(altFont);
     textSize(17);
     //text("SELECT THE SIMULATION YOU WOULD LIKE TO START",(width-380)/2,((height-40)/2)); 
     //Out.resize(0,332);
     //InOut.resize(0,332);
     //image(Out, 35,35);
     //image(InOut,35,375);  
     //text("Moderna", 45,60);
     //text("Pfizer",45,400);
     //noFill();
     //rect(30,35,680,330, 5);
     //rect(30,375,680,330, 5);
     
     Pfizer.resize(0,200);
     image(Pfizer,32,90);
     text("EFFICACY 90%",45,60);
     textSize(15);
     text("Duration Between Vaccinations: 21 DAYS",45,75);
     
     Moderna.resize(0,210);
     image(Moderna,385,90);
     textSize(15);
     text("EFFICACY 95%", 385,60);
     text("Duration Between Vaccination: 28 DAYS",385,75);
     
     Oxford.resize(0,300);
     image(Oxford,32,390);
     text("EFFICACY 80%",45,400);
     textSize(15);
     text("Duration Between Vaccinations: 8-12 WEEKS",45,415);
     
     Johnson.resize(0,60);
     image(Johnson,395,460);
     text("EFFICACY 85%", 385 ,400);
     textSize(15);
     text("Single Shot Vaccine",385,415);
     
     noFill();
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
    text(int(total) +"  AGENTS", xStat+349, yAssumption-12);
    text(dayCounter+ " DAYS |"  + " CASES: " + nf(round(numSick+numHealed+numDead),3), xStat+360, yStats-40); 
    
    //textSize(14);
    text("FATALITY RATE: " + nf(percentCFR, 0, 2) + "%", xStat+360, ySick);
    
    text("RECOVERED: " + nf(int(numHealed),3), xStat+360, yDay);

    text("DEATHS: " + nf(int(numDead),3), xStat+360, yInfect);
    
    text("SUSCEPTIBILITY: "+ round(100-map(numHealed,0, 1000, 0, 100)) + "%" , xStat+360, yAssumption+20);
   
    text("R 0: 2", xStat+360, yAssumption+45);

    textAlign(LEFT);
    
    text("INCUBATION: 4-6 DAYS" , xStat, yAssumption+20);
    
    text("INFECTIOUS: 3-7 DAYS" , xStat, yAssumption+45);

    text("INFECTIOUS: " + int(numSick), xStat+18, yInfect);
    
    text("EPIDEMIC CURVE ", xStat, (ySick-yInfect)+ySick+10);

    text("EXPOSED: " + int(numInfected), xStat+18, yDay);
    
    text("VACCINATION", xStat, yButton1-50);

    text("INFECTIOUS IN ISOLATION", xStat, yButton1-10);
    
    text("FACE COVERING", xStat+20, yButton2-25);
    
    text("RATE OF VACCINATION", xStat+8, yButton3-40);
    
    //text("FACE COVERING", xStat+18, yButton3+10);
    
    text("PREVALENCE: "+nf(percentAffected, 0, 2) + "%", xStat, ySick);
    text("INITIALLY VACCINATED: " + int(firstvacc), xStat+13, yDay-45);
    text(" FULLY VACCINATED: " + int(secondvacc),xStat+13, yDay-22);
    
    strokeWeight(1);
    noFill();
    noStroke();
    fill(#F51414); 
    ellipse(xStat+7, yDay-50, 9,9);
    noStroke();
    
    strokeWeight(1);
    noFill();
    noStroke();
    fill(#39E307); 
    ellipse(xStat+7, yDay-27, 9,9);
    noStroke();
    
    
   
   // text("USER FEEDBACK", xStat, yTitle+21);
   
    textSize(16);
    fill(255);
    
    text("ASSUMPTIONS", xStat, yAssumption-12);

    text("INTERVENTIONS", xStat, yButton1-75);
    
    text("RESULTS", xStat, yStats-40);

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
    fill(#EAADAF); 
    //ellipse(xStat+6, yButton3-44, 9, 9);
    
    
    //// the ellipse for face covering
    strokeWeight(1);
    noFill();
    stroke(62,214,43); 
    ellipse(xStat+7, yButton3-93, 9,9);
    
    
    fill(#0958D3); 
    noStroke();
    ellipse( xStat+230, yDay-5, 5, 5);
    
    fill(255); 
    noStroke();
    ellipse( xStat+358, yAssumption-18, 4, 4);

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
      
       if(a1){
         fill(180);
       }
       rect(xStat,yButton2-20,65,15,7);
       fill(0);
       if(!a1){
       fill(200);
       }
       
       text("0%", xStat+34,yPercent2-27);
       
       noFill();
       if(a2){
         fill(180);
       }
       rect(xStat+74,yButton2-20,65,15, 7);
       fill(0);
       if(!a2){
       fill(200);
       }
       
       text("25%", xStat+109,yPercent2-27);
       
       noFill();
       if(a3){
         fill(180);
       }
       rect(xStat+149,yButton2-20,65,15, 7);
       fill(0);
       if(!a3){
       fill(200);
       }
       
       text("50%", xStat+184,yPercent2-27);
       
       noFill();
       if(a4){
         fill(180);
       }
       rect(xStat+223,yButton2-20,65,15, 7);
       fill(0);
       if(!a4){
       fill(200);
       }
       
       text("75%", xStat+259,yPercent2-27);
       noFill();
       
       noFill();
       if(a5){
         fill(180);
       }
       rect(xStat+297,yButton2-20,65,15, 7);
       fill(0);
       if(!a5){
       fill(200);
       }
       
       text("100%", xStat+329,yPercent2-27);
       
       
       noFill();
      ////Winter 2021
      // intervention bar for vaccination rate
       if(c1){
         fill(180);
       }
       rect(xStat,yButton3-30,65,15, 7);
       fill(0);
       if(!c1){
       fill(200);
       }
       
       text("0.0%", xStat+34,yPercent3-37);
       
       noFill();
       if(c2){
         fill(180);
       }
       rect(xStat+74,yButton3-30,65,15, 7);
       fill(0);
       if(!c2){
       fill(200);
       }
       
       text("0.3%", xStat+109,yPercent3-37);
       
       noFill();
       if(c3){
         fill(180);
       }
       rect(xStat+149,yButton3-30,65,15, 7);
       fill(0);
       if(!c3){
       fill(200);
       }
       
       text("0.6%", xStat+184,yPercent3-37);
       
       noFill();
       if(c4){
         fill(180);
       }
       rect(xStat+223,yButton3-30,65,15, 7);
       fill(0);
       if(!c4){
       fill(200);
       }
       
       text("0.9%", xStat+259,yPercent3-37);
       noFill();
       
       noFill();
       if(c5){
         fill(180);
       }
       rect(xStat+297,yButton3-30,65,15, 7);
       fill(0);
       if(!c5){
       fill(200);
       }
       
       text("1.2%", xStat+329,yPercent3-37);
    noFill();
    
    //if(a1){
    //     fill(180);
    //   }
    //   rect(xStat,yButton3+20,65,15, 7);
    //   fill(0);
    //   if(!a1){
    //   fill(200);
    //   }
       
    //   text("0%", xStat+34,yPercent3+13);
       
    //   noFill();
    //   if(a2){
    //     fill(180);
    //   }
    //   rect(xStat+74,yButton3+20,65,15, 7);
    //   fill(0);
    //   if(!a2){
    //   fill(200);
    //   }
       
    //   text("25%", xStat+109,yPercent3+13);
       
    //   noFill();
    //   if(a3){
    //     fill(180);
    //   }
    //   rect(xStat+149,yButton3+20,65,15, 7);
    //   fill(0);
    //   if(!a3){
    //   fill(200);
    //   }
       
    //   text("50%", xStat+184,yPercent3+13);
       
    //   noFill();
    //   if(a4){
    //     fill(180);
    //   }
    //   rect(xStat+223,yButton3+20,65,15, 7);
    //   fill(0);
    //   if(!a4){
    //   fill(200);
    //   }
       
    //   text("75%", xStat+259,yPercent3+13);
    //   noFill();
       
    //   noFill();
    //   if(a5){
    //     fill(180);
    //   }
    //   rect(xStat+297,yButton3+20,65,15, 7);
    //   fill(0);
    //   if(!a5){
    //   fill(200);
    //   }
       
    //   text("100%", xStat+329,yPercent3+13);
    //noFill();
    
    if(b1){
         fill(180);
       }
       rect(xStat,yButton1-44,65,15, 7);
       fill(0);
       if(!b1){
       fill(200);
       }
       
       text("0%", xStat+34,yPercent-52);
       
       noFill();
       if(b2){
         fill(180);
         fill(#93969B);
       rect(xStat,yButton1-44,65,15, 7);
       }
       //fill(#93969B);
       //rect(xStat,yButton1-44,65,15, 7)
       rect(xStat+74,yButton1-44,65,15, 7);
       fill(0);
       if(!b2){
       fill(200);
       }
       
       text("25%", xStat+109,yPercent-52);
       
       noFill();
       if(b3){
         fill(180);
         fill(#93969B);
       rect(xStat,yButton1-44,65,15, 7);
        rect(xStat+74,yButton1-44,65,15, 7);
       }
       rect(xStat+149,yButton1-44,65,15, 7);
       fill(0);
       if(!b3){
       fill(200);
       }
       
       text("50%", xStat+184,yPercent-52);
       
       noFill();
       if(b4){
         fill(180);
         fill(#93969B);
       rect(xStat,yButton1-44,65,15, 7);
        rect(xStat+74,yButton1-44,65,15, 7);
        rect(xStat+149,yButton1-44,65,15, 7);
       }
       rect(xStat+223,yButton1-44,65,15, 7);
       fill(0);
       if(!b4){
       fill(200);
       }
       
       text("75%", xStat+259,yPercent-52);
       noFill();
       
       noFill();
       if(b5){
         fill(180);
         fill(#93969B);
       rect(xStat,yButton1-44,65,15, 7);
        rect(xStat+74,yButton1-44,65,15, 7);
        rect(xStat+149,yButton1-44,65,15, 7);
          rect(xStat+223,yButton1-44,65,15, 7);
       }
       rect(xStat+297,yButton1-44,65,15, 7);
       fill(0);
       if(!b5){
       fill(200);
       }
       
       text("100%", xStat+329,yPercent-52);
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
    
    if (numSick >= 600){
      adjust3 = true;
    }
    
      if( numSick >= 900){
      adjust4 = true;
    }
    
    if(numSick >= 2000){
      adjust5 = true;
    }
    
    if(numSick >3500){
      adjust6 = true;
    }
    
     
    if(adjust){
    yInfected   = (yInfected+yCFR)/2;
    yLine = 713 -25;
    }
    
    if (adjust2) { 
        yInfected   = (yInfected+yCFR)/2; 
        yLine = 713 - 13;
    } 
    
    if (adjust3){
     yInfected   = (yInfected+yCFR)/2; 
    yLine = 713 - 13;
    }
    
     if (adjust4){
     yInfected   = (yInfected+yCFR)/2; 
    yLine = 713 - 13;
    }
    
     if (adjust5){
     yInfected   = (yInfected+yCFR)/2; 
    yLine = 713 - 13;
    }
    
     if (adjust6){
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
        if ((person1.sick )){
        for (int j = i + 1; j < population.size(); j += 1)

        {
            Agent person2 = population.get(j);
            
            
            float distance = dist(person1.loc.x, person1.loc.y, person2.loc.x, person2.loc.y);

            // first condition

            if (distance <= spreadDistance && person1.sick && !person2.sick && !person2.recovered  && !person1.sickIsolate)

            {
              ////Winter 2021
              // infection probability if the agesnts are not vaccinated
              if(!person2.vaccinatedfirst){
              
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
                    population.remove(person2);
                    infectionLine(person1,person2);
                }
                infectionLine(person1,person2);
              }
              //Winter 2021
              //infection probability if agents have been vaacinated with the first dose
              if(person2.vaccinatedfirst){
                infectionProbability = 0.05;
              
              if(person2.socialDistance){
                
                infectionProbability = .03;
                
              }
              
              if (person2.wearingMask && !person1.wearingMask){
                infectionProbability = .04;
              }
              
               if (person2.wearingMask && person1.wearingMask){
                infectionProbability = .01;
              }
              
              if (!person2.wearingMask && person1.wearingMask){
                infectionProbability = .02;
              }
              

                if (prob(infectionProbability) && !person1.isolate) {

                    person2.getInfected();
                    sickAgents.add(person2);
                    population.remove(person2);
                }
                infectionLine(person1,person2);
              }
              //Winter 2021
              // infection probility if agents have been fully vaccinated with their particular vaccination company
              if(!person2.vaccinatedfirst && person2.vaccinatedsecond){
              if (moderna){
              infectionProbability = 0.005;
              if(person2.socialDistance){
                
                infectionProbability = .003;
                
              }
              
              if (person2.wearingMask && !person1.wearingMask){
                infectionProbability = .04;
              }
              
               if (person2.wearingMask && person1.wearingMask){
                infectionProbability = .003;
              }
              
              if (!person2.wearingMask && person1.wearingMask){
                infectionProbability = .006;
              }
              
                if (prob(infectionProbability) && !person1.isolate) {

                    person2.getInfected();
                    sickAgents.add(person2);
                    population.remove(person2);
                }
            }
            
            if (johnson){
              infectionProbability = 0.015;
              if(person2.socialDistance){
                
                infectionProbability = .009;
                
              }
              
              if (person2.wearingMask && !person1.wearingMask){
                infectionProbability = .012;
              }
              
               if (person2.wearingMask && person1.wearingMask){
                infectionProbability = .012;
              }
              
              if (!person2.wearingMask && person1.wearingMask){
                infectionProbability = .002;
              }
              
                if (prob(infectionProbability) && !person1.isolate) {

                    person2.getInfected();
                    sickAgents.add(person2);
                    population.remove(person2);
                }
            } 
            
            if(pfizer){
              infectionProbability = 0.01;
              if(person2.socialDistance){
                
                infectionProbability = .006;
                
              }
              
              if (person2.wearingMask && !person1.wearingMask){
                infectionProbability = .008;
              }
              
               if (person2.wearingMask && person1.wearingMask){
                infectionProbability = .002;
              }
              
              if (!person2.wearingMask && person1.wearingMask){
                infectionProbability = .004;
              }
              

                if (prob(infectionProbability) && !person1.isolate) {

                    person2.getInfected();
                    sickAgents.add(person2);
                    population.remove(person2);
                    infectionLine(person1,person2);
                }
              }
              if(oxford){
                infectionProbability = 0.02;
                if(person2.socialDistance){
                
                infectionProbability = .012;
                
              }
              
              if (person2.wearingMask && !person1.wearingMask){
                infectionProbability = .016;
              }
              
               if (person2.wearingMask && person1.wearingMask){
                infectionProbability = .004;
              }
              
              if (!person2.wearingMask && person1.wearingMask){
                infectionProbability = .008;
              }
              

                if (prob(infectionProbability) && !person1.isolate) {

                    person2.getInfected();
                    sickAgents.add(person2);
                    population.remove(person2);
                    infectionLine(person1,person2);
                }
              }
              
              }
                         
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
        
           if((person1.vel.x == 0 || person2.vel.x == 0 || person1.recovered || person2.recovered)){
        noStroke();//?
     }
     strokeWeight(3);
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
    total = sickAgents.size() + population.size()+1;
    infectedPerson.getInfected();
    //boolean popselection = false; 
//boolean efficasySelection = false; 

   if(home && !popselection && !efficasySelection){
   if(mouseX >= ((width-400)/2)-90 && mouseX <= ((width-400)/2)+90 && mouseY >= ((height-40)/2)-15 && mouseY <= ((height-40)/2)){
     home = false; 
     popselection = true; 
     efficasySelection = false;
     clicks = 0;
   }
   }
   
   if (popselection && !home && clicks > 0){
     if(mouseX >= 40 && mouseX <= 350 && mouseY >= 40 && mouseY <= 360){
    pop1 = true;
    pop2 = false; 
    //selectPop = false;
    //selection = true;
    }
    if(mouseX >= 40 && mouseX <= 350 && mouseY >= 390 && mouseY <= 680){
    pop2 = true; 
    pop1= false; 
    //selectPop = false;
    //selection = true;
    }
    
    if(popselection && clicks >= 1 && mouseX >= 40 && mouseX <= 680 && mouseY >= 40 && mouseY <= 680 ){
      popselection = false;
      efficasySelection = true;
      clicks = 0;
    }
   }
   
   
   
   
   
    if(mouseX<width-400 &&  mouseY<height-30 && !over){ 
    if(efficasySelection && !isSetup && !home && !popselection){
    if(mouseX >= 40 && mouseX <= 350 && mouseY >= 40 && mouseY <= 360){
     
    if(!isSetup && clicks >= 1){
            //adjust = false;
            //adjust2 = false;
            isSetup = true;
            efficasySelection = false;
            population.clear();
            sickAgents.clear();
            pfizer = true; 
            moderna = false;
            johnson = false; 
            oxford = false; 
  

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
    }
    if(efficasySelection && !isSetup && !home && !popselection){
   if(mouseX >= 360 && mouseX <= 680 && mouseY >= 40 && mouseY <= 360){
   if(!isSetup && clicks >= 1){
            //adjust = false;
            //adjust2 = false;
             isSetup = true;
              efficasySelection = false;
            population.clear();
            moderna = true;
            pfizer = false;
            johnson = false; 
            oxford = false; 
           

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
    } 
    if(efficasySelection && !isSetup && !home && !popselection){
   if(mouseX >= 40 && mouseX <= 350 && mouseY >= 390 && mouseY <= 680){
   if(!isSetup && clicks >= 1){
            //adjust = false;
            //adjust2 = false;
             isSetup = true;
              efficasySelection = false;
            population.clear();
            oxford = true;
            pfizer = false;
            johnson = false; 
            moderna = false; 
           

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
    } 
    
    
   if(efficasySelection && !isSetup && !home && !popselection){
   if(mouseX >= 360 && mouseX <= 680 && mouseY >= 390 && mouseY <= 680){
   if(!isSetup && clicks >= 1){
            //adjust = false;
            //adjust2 = false;
             isSetup = true;
              efficasySelection = false;
            population.clear();
            johnson = true;
            pfizer = false;
            moderna = false; 
            oxford = false; 
           

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
    } 
    

    if(isSetup && total < (initialPopulationSize + 20)){
    infectedPerson.loc.x = mouseX;

    infectedPerson.loc.y = mouseY;

    //population.add(infectedPerson);
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
      if(!efficasySelection){
        if(!popselection){
      if(!about){
       about = true; 
      }
        }
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
      sickAgents.clear();
      popselection = false; 
      pop1 = false; 
      pop2 = false; 
      home= true; 
      efficasySelection = false; 
      clicks = -1;
      
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

        c1 = true;
        c2 = false;
        c3 = false;
        c4 = false;
        c5 = false;

        a1 = true;
        a2 = false;
        a3 = false; 
        a4 = false; 
        a5 = false;
        
        b1 = true;
        b2 = false;
        b3 = false; 
        b4 = false; 
        b5 = false;

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
      a1 = true;
      a2 = false;
      a3 = false;
      a4 = false;
      a5 = false;
    }
    
    if(mouseX >= xStat+74 && mouseX <= (xStat+139) && mouseY >= yButton2-15 && mouseY <= (yButton2-4)){
      a1 = false;
      a2 = true;
      a3 = false;
      a4 = false;
      a5 = false;
    }
    
    if(mouseX >= xStat+149 && mouseX <= (xStat+214) && mouseY >= yButton2-15 && mouseY <= (yButton2-4)){
      a1 = false;
      a2 = false;
      a3 = true;
      a4 = false;
      a5 = false;
    }
    if(mouseX >= xStat+223 && mouseX <= (xStat+288) && mouseY >= yButton2-15 && mouseY <= (yButton2-4)){
      a1 = false;
      a2 = false;
      a3 = false;
      a4 = true;
      a5 = false;
    }
    if(mouseX >= xStat+297 && mouseX <= (xStat+362) && mouseY >= yButton2-15 && mouseY <= (yButton2-4)){
      a1 = false;
      a2 = false;
      a3 = false;
      a4 = false;
      a5 = true;
    }
    
    if(mouseX >= xStat && mouseX <= (xStat+65) && mouseY >= yButton3-30 && mouseY <= (yButton3-15)){
      c1 = true;
      c2 = false;
      c3 = false;
      c4 = false;
      c5 = false;
    }
    
    if(mouseX >= xStat+74 && mouseX <= (xStat+139) && mouseY >= yButton3-30 && mouseY <= (yButton3-15)){
      c1 = false;
      c2 = true;
      c3 = false;
      c4 = false;
      c5 = false;
    }
    
    if(mouseX >= xStat+149 && mouseX <= (xStat+214) && mouseY >= yButton3-30 && mouseY <= (yButton3-15)){
      c1 = false;
      c2 = false;
      c3 = true;
      c4 = false;
      c5 = false;
    }
    if(mouseX >= xStat+223 && mouseX <= (xStat+288) && mouseY >= yButton3-30 && mouseY <= (yButton3-15)){
      c1 = false;
      c2 = false;
      c3 = false;
      c4 = true;
      c5 = false;
    }
    if(mouseX >= xStat+297 && mouseX <= (xStat+362) && mouseY >= yButton3-30 && mouseY <= (yButton3-15)){
      c1 = false;
      c2 = false;
      c3 = false;
      c4 = false;
      c5 = true;
    }
    
    //if(mouseX >= xStat && mouseX <= (xStat+65) && mouseY >= yButton3+20 && mouseY <= (yButton3+35)){
    //  a1 = true;
    //  a2 = false;
    //  a3 = false;
    //  a4 = false;
    //  a5 = false;
    //}
    
    //if(mouseX >= xStat+74 && mouseX <= (xStat+139) && mouseY >= yButton3+20 && mouseY <= (yButton3+35)){
    //  a1 = false;
    //  a2 = true;
    //  a3 = false;
    //  a4 = false;
    //  a5 = false;
    //}
    
    //if(mouseX >= xStat+149 && mouseX <= (xStat+214) && mouseY >= yButton3+20 && mouseY <= (yButton3+35)){
    //  a1 = false;
    //  a2 = false;
    //  a3 = true;
    //  a4 = false;
    //  a5 = false;
    //}
    
    //if(mouseX >= xStat+223 && mouseX <= (xStat+288) && mouseY >= yButton3+20 && mouseY <= (yButton3+35)){
    //  a1 = false;
    //  a2 = false;
    //  a3 = false;
    //  a4 = true;
    //  a5 = false;
    //}
    //if(mouseX >= xStat+297 && mouseX <= (xStat+362) && mouseY >= yButton3+20 && mouseY <= (yButton3+35)){
    //  a1 = false;
    //  a2 = false;
    //  a3 = false;
    //  a4 = false;
    //  a5 = true;
    //}
    
     if(mouseX >= xStat && mouseX <= (xStat+65) && mouseY >= yButton1-43 && mouseY <= (yButton1-28)){
      s1 = true;
      s2 = false;
      s3 = false;
      s4 = false;
      s5 = false;
    }
    
    if(mouseX >= xStat+74 && mouseX <= (xStat+139) && mouseY >= yButton1-43 && mouseY <= (yButton1-28)){
      if (!b3 && !b4 && !b5){
      b1 = false;
      b2 = true;
      b3 = false;
      b4 = false;
      b5 = false;
      }
    }
    
    if(mouseX >= xStat+149 && mouseX <= (xStat+214) && mouseY >= yButton1-43 && mouseY <= (yButton1-28)){
      if(!b4 && !b5){
      b1 = false;
      b2 = false;
      b3 = true;
      b4 = false;
      b5 = false;
      }
    }
    
    if(mouseX >= xStat+223 && mouseX <= (xStat+288) && mouseY >= yButton1-43 && mouseY <= (yButton1-28)){
      if(!b5){
      b1 = false;
      b2 = false;
      b3 = false;
      b4 = true;
      b5 = false;
      }
    }
    
    if(mouseX >= xStat+297 && mouseX <= (xStat+362) && mouseY >= yButton1-43 && mouseY <= (yButton1-28)){
      b1 = false;
      b2 = false;
      b3 = false;
      b4 = false;
      b5 = true;
    }
     
}
void mouseClicked(){
 
  clicks = clicks+1;
  //println(clicks);
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
  
  int frame; 

  PVector target;

  int rad;

  int perHealthy = 100;
  
  int days = 0;

  float t = frameCount;
  float a = frameCount; 
  
  float randomNum = random(0, 1);

  float sickIsolateRate;
  
  float vaccinationRate;
  
  float travelIsolate;
  
  float maskTransmissionRate;
  
  boolean sickIsolate = false;
  
  boolean wearingMask = false;
  
  boolean socialDistance = false;
  
  boolean susceptible = true;
  
  boolean isolate = false;
  
  boolean isolateDone = false;
  
  boolean traced = false;
  
  boolean vaccinatedfirst = false; 
  boolean vaccinatedsecond = false;
  
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
  //Winter 2021
  //vaccination process of agnets getting the booster dose to make them fully vaccinated with tespest to the time
  if (vaccinatedfirst){
   
   a +=1;
   if(pfizer){
   if (a >= random(1260,1320)) {    

        getVaccintedtwice();
      }
   }
   if( moderna){
   if (a >= random(1680,1740)) {    

        getVaccintedtwice();
      }
   }
   
   if(oxford){
   if (a >= random(3360,5040)) {    

        getVaccintedtwice();
      }
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
    
    if(b1){
        vaccinationRate = 0.0;
      }
      if(b2){
        vaccinationRate = 0.25;
      }
      if(b3){
        vaccinationRate = 0.5;
      }
      if(b4){
        vaccinationRate = 0.75;
      }
      if(b5){
        vaccinationRate = 1;
      }
      if (randomNum < vaccinationRate){
         recovered = true;     
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
      fill(#0958D3); 
      rad = 5;
    }
    
    if (dead) {
      susceptible = false;
      noFill();
      vel = new PVector(0,0);
      rad = 0;
    }
    
    if (vaccinatedfirst){
      susceptible = false;
      fill(#FA1946);
      rad = 5;
    }
    
    noStroke();
    if(pop1){
    ellipse( loc.x, loc.y, rad, rad);
    }
    if(pop2){
     ellipse( loc.x, loc.y, rad-2, rad-2);
    }

   if (isolate) {
      vel = new PVector(0, 0);  
    }

    //add Halos
    strokeWeight(1);
    noFill();

    if ( sick ) {
      if(!wearingMask && !recovered){
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
      fill(#EAADAF);
      //stroke(#E82A2A);
      ellipse(loc.x, loc.y, 5, 5);
    } 
    
      if (wearingMask){
        strokeWeight(1);
       stroke(62,214,43); 
       ellipse( loc.x, loc.y, 8, 8);
    }
    
    if (vaccinatedsecond){
        susceptible = false;
      fill(#17E82D);
      rad = 5;   
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
  ////Winter 2021
  //Ehen agents get vaccinated with the first dose 
  void getVaccinated(){
    vaccinatedfirst = true;
    a =0;
    //recovered = true; 
  }
  
  //Winter 2021
  //When agents get vaccinated with the second dose 
  void getVaccintedtwice(){
    vaccinatedfirst = false;
    //recovered = true; 
    vaccinatedsecond = true; 
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
