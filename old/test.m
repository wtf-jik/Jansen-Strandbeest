function [out] = test(x, y);

persistent harray;

if isempty(harray)
	hf = figure();
	hp = line([x(1) x(2)],[y(1) y(2)]);
	axis([0 10 0 10]);
	harray = [hf hp];
else
	set(harray(2), 'XData', x, 'YData', y);
end

out = harray;