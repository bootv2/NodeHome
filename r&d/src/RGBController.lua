print("[i] LED strip initializing...")

r = 1;
g = 1;
b = 1;

pwm.setup(1,60,1023)
pwm.start(1)

pwm.setup(5,60,1);
pwm.start(5);
pwm.setup(6,60,1);
pwm.start(6);
pwm.setup(7,60,1);
pwm.start(7);

pwm.setduty(6, r)
pwm.setduty(5, g)
pwm.setduty(7, b)


tmr.alarm(3,20,1,function()
  pwm.setduty(5,r);
  g = g
  pwm.setduty(6,g);
  b = b
  pwm.setduty(7,b);
end)

function led(red,green,blue) 
    r = red
    g = green
    b = blue
end

function runRGBString(uri)
    r, g, b = getRGBFromString(uri)
end
