print("PWM Function test")
pwm.setup(6,500,1023);
pwm.start(6);
pwm.setup(5,500,1023);
pwm.start(5);
pwm.setup(7,500,1023);
pwm.start(7);

     
local r=666;
local g = 0;
local b = 333;
local flagr=5;
local flagg=5;
local flagb=5;
tmr.alarm(5,20,1,function()
  pwm.setduty(5,r);
  if flagr==1 then 
    r=r-10;
  
    if r<128 then 
      flagr=0 r=128 
    end
  
    else
    r= r+10;
  
    if r>1023 then 
      flagr=1 
      r=1023 
    end
  end
end)

tmr.alarm(4,30,1,function()
  pwm.setduty(6,g);
  if flagg==1 then 
    g=g-10;
  
    if g<128 then 
      flagg=0 g=128 
    end
  
    else
    g= g+10;
  
    if g>1023 then 
      flagg=1 
      g=1023 
    end
  end
end)

tmr.alarm(3,50,1,function()
  pwm.setduty(7,b);
  if flagb==1 then 
    b=b-10;
  
    if b<128 then 
      flagb=0 b=128 
    end
  
    else
    b= b+10;
  
    if b>1023 then 
      flagb=1 
      b=1023 
    end
  end
end)
