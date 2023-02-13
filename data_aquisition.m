clc;clear all;close all;

name = 'odpor';

mkdir(['data/' name])

camera = webcam;
net = alexnet;
inputSize = net.Layers(1).InputSize(1:2);

im = snapshot(camera);
im = imresize(im,inputSize);
image(im)
time = replace(replace(replace(datestr(now),':','_'),'-','_'),' ','_');
imwrite(im,['data/' name '/img_' time '.png'])