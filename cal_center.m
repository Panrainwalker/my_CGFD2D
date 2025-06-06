hWx(4:end-3,4:end-3,:) = (W(4:end-3,5:end-2,:) - W(4:end-3,3:end-4,:)) ./ (2*dx);

hWz(4:end-3,4:end-3,:) = (W(5:end-2,4:end-3,:) - W(3:end-4,4:end-3,:)) ./ (2*dx);
