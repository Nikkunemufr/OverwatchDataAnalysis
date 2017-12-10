function res = removeSmallObj(BW, minAreaLimit, minWHRatio, maxWHRatio)
regionsTemp = regionprops(BW,'Area', 'BoundingBox','PixelList');
NR = numel(regionsTemp);
res = zeros(size(BW, 1), size(BW, 2));
validRegions = [];
for k = 1:NR
    area = prod(regionsTemp(k).BoundingBox(3:4));
    w = regionsTemp(k).BoundingBox(3);
    h = regionsTemp(k).BoundingBox(4);
    if area > minAreaLimit % Region is valid if area > 500
        if minWHRatio <= w/h && w/h <= maxWHRatio
            validRegions  = [validRegions; regionsTemp(k)];
        end     
    end
end

for i = 1:size(validRegions, 1)
    for j = 1:size(validRegions(i).PixelList)
        x = validRegions(i).PixelList(j, 1);
        y = validRegions(i).PixelList(j, 2);
        res(y, x) = 1;
    end
end

end