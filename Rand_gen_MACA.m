% Algorithm 5.1 Rand_gen_MACA
% Input: n - the size of MACA, 2^m is the number of attractors and m is the number of bits
% in Pseudo Exhaustive Field (PEF, Definition 5.2)
% Output: T matrix representing an MACA with 2m attractor
% Step 1: Randomly divide (n − m) into d1, d2 · · · dp.
% Step 2: Randomly arrange the sequence of xdi ’s and (1+x)’s to form the pseudo-chromosome.
% Step 3: Synthesize Tˆ matrix corresponding to the ‘elementary divisors xdi ’, i = 1 to p. i
% Step 4: Synthesize Tˆ matrix for each elementary divisor (1 + x), j = 1 to m. j
% Step 5: Select any one of the methods I, II or III 
function code = Rand_gen_MACA(sizeN, attractorM)
    %randomly divide n -m into d_1, d_2...
    temp = sizeN - attractorM;
    p = unidrnd(temp-attractorM) + attractorM;
    
    %the random number generation for known sum algorithm from MATLAB forum
    m=1:temp;
    a=m(sort(randperm(temp,p)));
    b=diff(a);
    b(end+1) = temp-sum(b);
    
    d = sort(b, 'descend');
    %calculate the position to put (x+1) terms
    x1 = size(d, 2) - 1; %pos can be the last?
    temp2 = randperm(x1);
    pos = sort(temp2(1, 1:attractorM)); %position is the gap for d
    
    temp3 = zeros(1, sizeN);
    insert = -1;
    for i = 1 : size(pos, 2)        
        if i ==1
            postmp = pos(i)+1;
            temp3(1, postmp) = insert;
            temp3(1,1:postmp-1) = d(1, 1:postmp-1);
            temp3(1, postmp+1:length(d)+1)=d(1, postmp:length(d));
        else
            postmp = pos(i)+i;
            tmp = temp3;
            temp3(1, postmp) = insert;
            temp3(1,1:postmp-1) = tmp(1, 1:postmp-1);
            temp3(1, postmp+1:length(d)+i+1) = tmp(1, postmp : length(d)+i);
        end
    end
    code1 = temp3(1, 1:sizeN);
    %convert to the formal chromsome code 
    accumulate = 0;
    acVec = zeros(1, length(code1)-length(pos));
    k = 0;
    for i = 1 : size(code1, 2)
        
        if (code1(1, i) == -1) || (code1(1, i) == 0)
            k = k +1;
            %accumulate the non-(-1)'s, which means the exponent of x 
            acVec(1,k) = accumulate;
            accumulate = 0;
        else
            accumulate = accumulate + code1(1, i);
        end
    end
    
    v = -2 * ones(size(acVec, 2), sizeN);
    
    for i = 1 : size(acVec, 2)
        temp4 = acVec(1, i);
        %for the number > 0
        if (acVec(1, i) > 0) && (acVec(1, i+1) ~= 0)
            if temp4 > 1
                x2 = zeros(1, temp4-1);
                y = [temp4 x2 -1];
            else
                y = [temp4 -1];
            end        
           %keep the record in the all -2 matrix
                for j = 1 : length(y)
                    v(i,j) = y(1, j);
                end
         %for the last number   
        else
            if (acVec(1, i)  > 0) && (acVec(1, i+1) == 0) 
                x2 = zeros(1, temp4-1);
                y = [temp4 x2];
            %keep the record in the all -2 matrix
                for j = 1 : length(y)
                    v(i,j) = y(1, j);
               end
            end
        end
    end
    % deal with the v matrix and construct the code
    code = zeros(1, length(code1));
    temp5 = 0;
    for i = 1 : size(v, 1)
        for j = 1 : size(v, 2)
            if v(i, j) >-2
                temp5 = temp5 + 1;
                code(1, temp5) = v(i,j);
            end
        end
    end
    
end
