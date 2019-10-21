function updateJacobian(handles)
global R q J;

J = R.jacob0(q);
% switch get(handles.popupmenuCI, 'Value')
%     case 1
%         J = iiwa_jacobian(R, q, 'normal');
%     case 2
%         J = iiwa_jacobian(R, q, 'simplify');
%         set(handles.editDetJ, 'String', num2str(det(J)));
%         set(handles.editManip, 'String', num2str(R.maniplty(q, 'yoshikawa')));
% end
set(handles.editCond, 'String', num2str(cond(J)));
set(handles.editManip, 'String', num2str(R.maniplty(q, 'yoshikawa')));
set(handles.editRankJ, 'String', num2str(rank(J)));
set(handles.textJsinguValue, 'String', m_jsingu(J));