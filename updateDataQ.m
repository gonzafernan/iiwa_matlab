function updateDataQ(handles)

global q;
q_ = [
    rad2deg(q(1))
    rad2deg(q(2))
    rad2deg(q(3))
    rad2deg(q(4))
    rad2deg(q(5))
    rad2deg(q(6))
    rad2deg(q(7))];

set(handles.q1, 'String', q_(1));
set(handles.q2, 'String', q_(2));
set(handles.q3, 'String', q_(3));
set(handles.q4, 'String', q_(4));
set(handles.q5, 'String', q_(5));
set(handles.q6, 'String', q_(6));
set(handles.q7, 'String', q_(7));

set(handles.sliderQ1, 'Value', q_(1));
set(handles.sliderQ2, 'Value', q_(2));
set(handles.sliderQ3, 'Value', q_(3));
set(handles.sliderQ4, 'Value', q_(4));
set(handles.sliderQ5, 'Value', q_(5));
set(handles.sliderQ6, 'Value', q_(6));
set(handles.sliderQ7, 'Value', q_(7));