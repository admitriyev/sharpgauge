function [DOut] = shuffleData(DIn)

% DIn = load("data-train1.txt");
DOut = zeros(size(DIn));
m = size(DIn, 1);
R = randperm(m);

for i = 1:m
	DOut(i,:) = DIn(R(i),:);
end

end