
clc
% Set-up the beginning Error is zero ( the numbers of images which are wrong detection).
load SVMModel.mat
load hog.mat
fprintf('\nDetecting...\n\n');
error = 0;
% Prepare the data for testing


testPos = getImagesInDir('./Testset/TestPositive/', true);
testNeg = getImagesInDir('./Testset/TestNegative/', true);

testSet = [testPos, testNeg];
GroupSet = zeros(length(testSet), 1);

targetLabels = [ones(length(testPos), 1); zeros(length(testNeg), 1)];

CAM = zeros(length(testSet), 1);
RESULT = zeros(length(testSet), 1);
GroupLabels = zeros(length(testSet), 1);
GroupScores = zeros(length(testSet), 1);
TIMEreg = zeros(length(testSet), 1);
TIME = zeros(length(testSet), 1);

for ii = 1 : length(testSet)

    % Get data in the next file.
    testImgPath = char(testSet(ii));
     
   
    % Load the image into a matrix.
    testImg = imread(testImgPath);
    
    [a, b, c] = size(testImg);
   if c > 1
     % Convert the RGB image to gray image if the input images are RGB
     % images
        grayTestImg  = rgb2gray(testImg);
   else 
        grayTestImg = testImg;
   end
    %resize the input images to 130x66 size
    grayTestImg = imresize(grayTestImg, [130 66]);
   
   tic;
    % Calculate the HOG descriptor for the window.
    T = getHOGDescriptor(hog, grayTestImg); 
   time = toc;
    TIME(ii, 1) = time;
    % Detect the testing images
  %  Group       = svmclassify(SVMStruct, T');
    

 %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 tic;
 [label,score] = predict(SVMModel,T');
 t_reg = toc;
 TIMEreg (ii,1) = t_reg;
 GroupLabels(ii, 1) = label;
% GroupScores (ii, 1) = (T' * SVMModel.Beta) + SVMModel.Bias;
 GroupScores (ii, 1) = T' * SVMModel.Beta;
    %GroupSet(ii) = Group;
    if  GroupLabels(ii, 1)  ~= targetLabels(ii, 1)
        error = error + 1;
    end
    
end

fprintf ('\nDone detection ! \n');
fprintf (' RESULT : \t');
fprintf('(%d / %d) %.2f%%\n', (length(testSet) - error), length(testSet), (length(testSet) - error) / length(testSet) * 100.0);


 image_pos = imread('TestIMG.jpg');
 image_neg = imread('TestIMG_non.jpg');
 gray_pos  = rgb2gray(image_pos);
 gray_neg  = rgb2gray(image_neg);
 gray_pos = imresize(gray_pos, [130 66]); 
 gray_neg = imresize(gray_neg, [130 66]);
  hog_pos = getHOGDescriptor(hog, gray_pos);
 hog_neg = getHOGDescriptor(hog, gray_neg);
 
% G = svmclassify(SVMStruct, hog_pos');
 %J = svmclassify(SVMStruct, hog_neg');
 % testing 
 KETQUA_pos = hog_pos' * SVMModel.Beta + SVMModel.Bias;
 KETQUA_neg = hog_neg' * SVMModel.Beta + SVMModel.Bias;
tic;
[labelPos,scorePos] = predict(SVMModel,hog_pos');
Treg = toc;
[labelNeg,scoreNeg] = predict(SVMModel,hog_neg');

% tic and toc function using to get the time of a process.

% D---E---M---O 


demoSet = getImagesInDir('./DemoSet/', true);

GroupDemoLabels = zeros(length(demoSet), 1);
% Detecting input demo data (include getting descriptor's input image and detecting them).
for iii = 1 : length(demoSet) 

    % Get demo data in the Demo Folder.
    demoImgPath = char(demoSet(iii));
     
   
    % Load the image into a matrix.
    demoImg = imread(demoImgPath);
    
    [d, e, f] = size(demoImg);
   if f > 1
     % Convert the RGB image to gray image if the input images are RGB
     % images
        grayDemoImg  = rgb2gray(demoImg);
   else 
        grayDemoImg = demoImg;
   end
    %resize the input images to 130x66 size
    grayDemoImg = imresize(grayDemoImg, [130 66]);
   
    % Calculate the HOG descriptor for the window.
    HOG_demo = getHOGDescriptor(hog, grayDemoImg); 
    % Detect the testing images
    
 [detect,scoresDemo] = predict(SVMModel,HOG_demo');
 GroupDemoLabels(iii, 1) = detect;
    
end

% Display the detected result
figure('name','HUMAN DETECTION RESULT');
for num = 1 : length(demoSet) 
	demoPath = char(demoSet(num));
	X = imread(demoPath);
    X = imresize(X, [130 66]);
    subplot(2,5,num);
	imshow(X);
	hold on;
 
	if  GroupDemoLabels(num, 1) == 1
		rectangle('Position', [1, 1,65 ,130 ], 'EdgeColor', 'g');
	else
		rectangle('Position', [1, 1, 65, 130], 'EdgeColor', 'r');
    end
    hold on;
end
