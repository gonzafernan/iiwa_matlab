function updateDataT(handles)

global T;

set(handles.tableT, 'data', T.T);
set(handles.editX, 'String', num2str(T.t(1)));
set(handles.editY, 'String', num2str(T.t(2)));
set(handles.editZ, 'String', num2str(T.t(3)));

aux = T.tr2rpy;
set(handles.editRoll, 'String', num2str(rad2deg(aux(1))));
set(handles.editPitch, 'String', num2str(rad2deg(aux(2))));
set(handles.editYaw, 'String', num2str(rad2deg(aux(3))));