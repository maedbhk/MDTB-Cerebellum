function checkTR(screen)
%% sc1 project 
% Maedbh King

% Checks time of incoming TRs and counts number of TRs

global TRreal timeOfTR;

[isPressed, timeTR, keyCode] = KbCheck(screen.keyBoard);

if (isPressed && keyCode(screen.pulseKey)) || (isPressed && keyCode(screen.pulseFive)) % sometimes TR key is '5' not 't'!!!
    if (timeTR-timeOfTR)>0.3
        TRreal = TRreal+1;
        timeOfTR = timeTR;
        fprintf('newTR: %d\n',TRreal);
    end;
end;