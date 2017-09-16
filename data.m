

% images path
input_folder= ['..', filesep, 'images', filesep];

%define image set to use during training and testing
image_set = 'trainval'; %training, validation, trainval
training_list=['..', filesep, 'image_sets', filesep, image_set, '.txt'];

test_im_list=['..', filesep, 'image_sets', filesep 'test.txt'];
%% Read training images
images=textread(training_list,'%s\n');
num_images=size(images,1);
grayIm = {};
TrainDensities = {};
for j=1:10
    im_path=[input_folder images{j}];
    im = imread(im_path);
    grayIm{j}=rgb2gray(im);
    [~,name,~] = fileparts(im_path);
    ground_truth = imread([input_folder name 'dots.png']);
    gtDensity= ground_truth;
    gtDensity = double(gtDensity(:,:,1))/255; %using the red channel
    TrainDensities{j}= imfilter(gtDensity,fspecial('gaussian', 15.0*6,15));
end

save('TrainImage.mat','grayIm','TrainDensities');


%% Read test images
test_images=textread(test_im_list,'%s\n');
grayTestIm = {};
TestDensities = {};

for j=1:10
    im_path=[input_folder test_images{j}];
    im = imread(im_path);
    grayTestIm{j}=rgb2gray(im);  
    [~,name,~] = fileparts(im_path);
    ground_truth = imread([input_folder name 'dots.png']);
    gtDensity= ground_truth;
    gtDensity = double(gtDensity(:,:,1))/255; %using the red channel
    TestDensities{j}= imfilter(gtDensity,fspecial('gaussian', 15.0*6,15));
end
 
save('TestImage.mat','grayTestIm','TestDensities');

%load('trainData.mat','train_x','train_y')
%load('testData.mat','test_x','test_y')

