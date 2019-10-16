function msg = m_jsingu(J)

% convert to row-echelon form
[R, jb] = rref(J);

depcols = setdiff( 1:numcols(J), jb);

msg = num2str(length(depcols)) + " linearly dependent joints:  ";
for d=depcols
    msg = msg + "q" + num2str(d) + " depends on: ";
    for k=find(R(:,d))
        msg = msg + "q" + num2str(k);
    end
    msg = msg + " -- ";
end