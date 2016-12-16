print("PWM Function test")
pwm.setup(6,500,1023);
pwm.start(6);
--pwm.setup(5,500,1023);
--pwm.start(5);
--pwm.setup(7,500,1023);
--pwm.start(7);

     
local r=0;
local g = 1000;
local b = 0;
local flagr=5;
local flagg=5;
local flagb=5;

tmr.alarm(4,30,1,function()
  pwm.setduty(6,g);
end)
