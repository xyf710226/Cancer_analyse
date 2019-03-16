function [High,Low,con3] = confid(React_High,React_Low)
H = abs(React_High.objective);
L = abs(React_Low.objective);
con1 = H - L;
con2 = round(con1);
con3 = zeros(length(con2),1);
for i = 1:length(con2)
    if con2(i) >= 1
        con3(i) = 1;
    end
    if con2(i) <= -1
        con3(i) = -1;
    end
    if con2(i) == 0
        con3(i) = 0;
    end
end
High = find(con3 == 1);
Low = find(con3 == -1);
High=unique([High;4616]);

