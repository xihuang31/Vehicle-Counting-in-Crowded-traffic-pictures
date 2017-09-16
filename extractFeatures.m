load('TrainImage.mat','grayIm','TrainDensities'); % load variables test_x test_y, train_x, train_y, 
features = grayIm;
gtDensities = TrainDensities;



%train_x = features(1:2,:);
%train_y = gtDensities(1:2,:);

%val_x = features(3:4,:);
%val_y = gtDensities(3:4,:);

% normalize
%[train_x, mu, sigma] = zscore(train_x);
%test_x = normalize(test_x, mu, sigma);
%val_x = normalize(val_x,mu,sigma);
train_x = zeros(100*10, 1260);
train_y = zeros(100*10, 1);
for i = 1:10
   featureCell = features{i};
   labelCell = gtDensities{i};
   for j = 1:10
       for k = 1:10
        train_x((i-1)*100+10*(j-1)+k,:) = extractHOGFeatures(featureCell((j-1)*48+1:48*j,(k-1)*64+1:64*k));
        if find(labelCell((j-1)*48+1: 48*j ,(k-1)*64+1:64*k) > 0)
            train_y((i-1)*100+10*(j-1)+k) = 1; 
        else
            train_x((i-1)*100+10*(j-1)+k) = 0;
        end
       end
   end
end

save('train2Data.mat','train_x','train_y');
