clc;
clear ALL;
%%
% Data generation

bitSize = 4;
pattern = zeros(1, 2^bitSize);

for i = 1 : 2^bitSize
    pattern(i) = i;
end

numOne = 2^(bitSize -1) - unidrnd(4);
numTwo = 2^(bitSize -1) - unidrnd(4);
temp = randperm(2^bitSize);

classOne = zeros(1, numOne);
for i = 1 : numOne
    classOne(i) = temp(i) - 1; %for n bits, the decimal num is 0 to 2^n -1
end

classTwo = zeros(1, numTwo);
for i = 1 : numTwo
    classTwo(i) = temp(2^bitSize+1-i) - 1;
end
%%
% convert data into binary logical vectors
patternOne = true(numOne, bitSize);
patternTwo = true(numTwo, bitSize);



