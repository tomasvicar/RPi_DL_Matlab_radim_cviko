function raspi_webcam_mynet()
%#codegen
%Create raspi & webcam obj
raspiObj = raspi();
cam      = webcam(raspiObj,1);

r_pin = 13;
g_pin = 6;
b_pin = 5;

configurePin(raspiObj,r_pin,'DigitalOutput') ;  
configurePin(raspiObj,g_pin,'DigitalOutput')   ;
configurePin(raspiObj,b_pin,'DigitalOutput')  ; 



%Initialize DNN and the input size
net        = coder.loadDeepLearningNetwork('netTransfer.mat');
inputSize  = [227, 227,3]; %net.Layers(1).InputSize;

%Initialize text to display
textToDisplay = '......';

% Main loop
start = tic;
fprintf('Entering into while loop.\n');
while true
    %Capture image from webcam
    img = snapshot(cam);
    
    elapsedTime = toc(start);
    %Process frames at 1 per second
    if elapsedTime > 1
        %Resize the image
        imgSizeAdjusted = imresize(img,inputSize(1:2));
        
        %Classify the input image
        [label,score] = net.classify(imgSizeAdjusted);
        maxScore = max(score);
        
        labelStr = cellstr(label);
        textToDisplay = sprintf('Label : %s \nScore : %f',labelStr{:},maxScore);

        writeDigitalPin(raspiObj,r_pin,0)
        writeDigitalPin(raspiObj,g_pin,0)
        writeDigitalPin(raspiObj,b_pin,0)

        if strcmp(labelStr{:},'led')
            writeDigitalPin(raspiObj,r_pin,1)
        else
            writeDigitalPin(raspiObj,g_pin,1)
        end

        start = tic;
    end
    
    %Display the predicted label
    img_label = insertText(img,[0,0],textToDisplay);
    displayImage(raspiObj,img_label);
end
end

