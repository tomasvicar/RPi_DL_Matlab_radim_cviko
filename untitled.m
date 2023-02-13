clc;clear all; close all;

camera = webcam;
% net = googlenet;
net = load('netTransfer.mat');
net = net.netTransfer;

inputSize = net.Layers(1).InputSize(1:2);



figure
while true
    im = snapshot(camera);
    image(im)
    im = imresize(im,inputSize);
    [label,score] = classify(net,im);
    title({char(label),num2str(max(score),2)});
    drawnow
end
