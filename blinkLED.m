function blinkLED()

r= raspi;

for i = 1:10
    
    disp(i)
    writeLED(r, "LED0", 0)
    pause(0.5)
    writeLED(r, "LED0", 1)
    pause(0.5)

end

end