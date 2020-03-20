function [f1, f2] = freqs(digit)
    if (digit == 1)||(digit == 2)||(digit == 3) 
        f1 = 697;
    elseif (digit == 4)||(digit == 5)||(digit == 6) 
        f1 = 770;
    elseif (digit == 7)||(digit == 8)||(digit == 9)
        f1 = 852;
    else 
        f1 = 941;
    end
    
    if (digit == 1)||(digit == 4)||(digit == 7)||(digit == '*')
        f2 = 1209;
    elseif (digit == 2)||(digit == 5)||(digit == 8)||(digit == 0)
        f2 = 1336;
    else
        f2 = 1477;
    end
end