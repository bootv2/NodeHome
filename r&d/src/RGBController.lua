print("PWM initializing...")
pwm.setup(6,500,1023);
pwm.start(6);
pwm.setup(5,500,1023);
pwm.start(5);
pwm.setup(7,500,1023);
pwm.start(7);

     
local modifier = 1;
local r=666;
local g = 0;
local b = 333;
local flagr=5;
local flagg=5;
local flagb=5;
tmr.alarm(5,5,1,function()
  pwm.setduty(5,r);
  if flagr==1 then 
    r=r-modifier;
  
    if r<10 then 
      flagr=0 r=10
    end
  
    else
    r= r+modifier;
  
    if r>1023 then 
      flagr=1 
      r=1023 
    end
  end
end)

tmr.alarm(4,6,1,function()
  pwm.setduty(6,g);
  if flagg==1 then 
    g=g-modifier;
  
    if g<10 then 
      flagg=0 g=10 
    end
  
    else
    g= g+modifier;
  
    if g>1023 then 
      flagg=1 
      g=1023 
    end
  end
end)

tmr.alarm(3,7,1,function()
  pwm.setduty(7,b);
  if flagb==1 then 
    b=b-modifier;
  
    if b<10 then 
      flagb=0 b=10 
    end
  
    else
    b= b+modifier;
  
    if b>1023 then 
      flagb=1 
      b=1023 
    end
  end
end)

function forceDuties()
  r = r
  pwm.setduty(5,r);
  g = g
  pwm.setduty(6,g);
  b = b
  pwm.setduty(7,b);
  r = r
end

function led(red,green,blue) 
    r = red
    g = green
    b = blue
    
    forceDuties()
end

function runRGBString(uri)
    r, g, b = getRGBFromString(uri)
end
