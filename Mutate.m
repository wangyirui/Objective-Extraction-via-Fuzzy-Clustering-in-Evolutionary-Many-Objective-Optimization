function Mutate()

global mop pMutation Eta_m   popc popm pop nPop;

x = popc;
delete = [];

for i1 = 1 : size(x, 1) %����ĺ����
    for i2 = 1 : mop.pdim
        r1 = rand;
        if r1 <= pMutation
            y = x(i1).Position(i2);
            yl = mop.varMin;
            yu = mop.varMax;
            delta1 = (y - yl) / (yu - yl);
            delta2 = (yu-y) / (yu - yl);
            u = rand;
            mut_pow = 1.0/(Eta_m+1.0);
            if u <= 0.5
                xy = 1.0 - delta1;
                val = 2 * u + (1-2*u)*(xy)^(Eta_m+1.0);
                deltaq = val^(mut_pow) - 1.0;
            else
                xy = 1 - delta2;
                val = 2.0*(1.0-u)+2.0*(u-0.5)*(xy)^(Eta_m+1.0);
                deltaq = 1.0 - (val)^(mut_pow);
            end
            y = y + deltaq * (yu - yl);
            if y > mop.varMax
                y = mop.varMax;
            elseif y < mop.varMin
                y = mop.varMin;
            end
            popm(i1).Position(i2) = y;
        else
            popm(i1).Position(i2) = x(i1).Position(i2);
        end
    end
    if isequal(popm(i1).Position, x(i1).Position) %δ�������죬��¼���кţ��ȴ��ӱ�������ȥ������
        delete = [delete i1];
    end
end

nDelete = size(delete, 2);
for i1 = 0 : nDelete - 1
    popm(delete(nDelete - i1), :) = [ ]; %����ɾ��������¼ɾ��δ������,�����ʼɾ������ǰ��Ԫ��������������
end

if ~isempty(popm)
    nPopm = size(popm, 1);
    for i1 = 1 : nPopm
        [popm(i1).RawCost, popm(i1).Cost, popm(i1).Constrains] ...
            = costFunction(mop, popm(i1).Position);
    end
    % Merge
    pop=[pop; popm];
end

end