function sc1_save_eyeTracking(edfFile)

% Maedbh King

Eyelink('stoprecording');
disp('recording has stopped');

Priority();

status=Eyelink('closefile');
if status~=0
    error('closefile error, status: %d',status);
else 
    fprintf('closing file (%s) \n',edfFile); 
end
status=Eyelink('ReceiveFile',edfFile,pwd,1);
if status~=0,
    warning('potential problem: ReceiveFile status: %d\n', status);
else
    fprintf('Receiving %s from host computer \n',edfFile)
end

if 2==exist(edfFile, 'file')
    fprintf('Data file ''%s'' can be found in ''%s''\n', edfFile, pwd);
else
    warning('unknown where data file went \n')
end