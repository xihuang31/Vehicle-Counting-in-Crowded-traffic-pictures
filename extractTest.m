load('TestImage.mat','grayTestIm','TestDensities'); % load variables test_x test_y, train_x, train_y, 
features = grayTestIm;
gtDensities = TestDensities;

test_x = zeros(100*10, 1260);
test_y = zeros(100*10, 1);
for i = 1:10
   featureCell = features{i};
   labelCell = gtDensities{i};
   for j = 1:10
       for k = 1:10
        test_x((i-1)*100+10*(j-1)+k,:) = extractHOGFeatures(featureCell((j-1)*48+1:48*j,(k-1)*64+1:64*k));
        if find(labelCell((j-1)*48+1: 48*j ,(k-1)*64+1:64*k) > 0)
            test_y((i-1)*100+10*(j-1)+k) = 1; 
        else
            test_y((i-1)*100+10*(j-1)+k) = 0;
        end
       end
   end
end

save('testData.mat','test_x','test_y');
