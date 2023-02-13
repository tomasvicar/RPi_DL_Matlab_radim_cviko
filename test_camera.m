function test_camera()

raspiObj = raspi()
cam = webcam(raspiObj,1);

img = snapshot(cam);

figure();
imshow(img,[])
drawnow;
pause(10)

end