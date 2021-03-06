function [A, f] = func_genOptJointGroup(storeItems, breakup, files, N, K, t)
M_reduce = zeros(1,K);
f = 0;
leftCur = find(breakup == '{');
rightCur = find(breakup == '}');
for iC = 1:length(leftCur)
    b = breakup(leftCur(iC):rightCur(iC)); % a break up
    canfindb = 0;
    Y = length(storeItems);
    X = length(storeItems{1});
    for iY = 1:Y-1
        for iX = 2:X
            if strfind(storeItems{iY}{iX}, b)
                canfindb = 1;
            end
        end
    end
    if  canfindb == 1 % can find b in previous, skip
        continue;
    else % a new 'b'
        f = f + 1; % f only increase when a new 'b' appears
        num_of_files_in_a_breakup = 0;
        for iN = 1:N % calculate # of files in this break up
            filename = files(iN);
            file = find(b == char(filename)); % {C123} {A126A136A236}': gives 9,13,17 OR 2 
            if ~isempty(file) % if can find this file
                num_of_files_in_a_breakup = num_of_files_in_a_breakup + length(file);
            end
        end
        for iUser = 1:K
            if length(find(b == int2str(iUser))) == num_of_files_in_a_breakup % a user appears this many times
                M_reduce(iUser) =  M_reduce(iUser) + 1;
            end
        end
    end

end
A = M_reduce;
f = f - 1;
    
    