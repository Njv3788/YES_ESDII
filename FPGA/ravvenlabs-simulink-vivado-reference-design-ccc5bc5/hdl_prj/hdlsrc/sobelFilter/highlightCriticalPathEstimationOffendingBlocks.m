open_system('sobelFilter');
open_system('gm_sobelFilter');
cs.HiliteType = 'user2';
cs.ForegroundColor = 'black';
cs.BackgroundColor = 'gray';
set_param(0, 'HiliteAncestorsData', cs);
hilite_system('gm_sobelFilter/conv_core/Reshape', 'user2');
annotate_port('gm_sobelFilter/conv_core/Reshape', 1, 1, 'Block not characterized');
hilite_system('sobelFilter/conv_core/Reshape', 'user2');
annotate_port('sobelFilter/conv_core/Reshape', 1, 1, 'Block not characterized');
cs.HiliteType = 'user2';
cs.ForegroundColor = 'black';
cs.BackgroundColor = 'gray';
set_param(0, 'HiliteAncestorsData', cs);
hilite_system('gm_sobelFilter/conv_core/t', 'user2');
annotate_port('gm_sobelFilter/conv_core/t', 1, 1, 'Block not characterized');
cs.HiliteType = 'user2';
cs.ForegroundColor = 'black';
cs.BackgroundColor = 'gray';
set_param(0, 'HiliteAncestorsData', cs);
hilite_system('gm_sobelFilter/conv_core/Transpose', 'user2');
annotate_port('gm_sobelFilter/conv_core/Transpose', 1, 1, 'Block not characterized');
hilite_system('sobelFilter/conv_core/Transpose', 'user2');
annotate_port('sobelFilter/conv_core/Transpose', 1, 1, 'Block not characterized');
cs.HiliteType = 'user2';
cs.ForegroundColor = 'black';
cs.BackgroundColor = 'gray';
set_param(0, 'HiliteAncestorsData', cs);
