function [salida] = trayectoria_grabacion2(ser, instruc, recorder1)
    salida = [];  % Inicializa una matriz vacía para almacenar las posiciones
    k = 1;
    p = 1;

    grabar = false;

    % Configurar y limpiar el buffer del puerto serie
    flushinput(ser);
    flushoutput(ser);

    % Mover el dispositivo a la posición inicial (0,0)
    writeline(ser, 'G0 X0 Y0');
    pause; % Pausar para permitir que el dispositivo se mueva a la posición inicial

     for p=1:height(instruc)
            % Enviar la instrucción actual
            a = instruc(p, :);
            writeline(ser, a);
            p = p + 1;

            if ~grabar
                disp("Empiezo a grabar");
                record(recorder1);
                grabar = true;
            end
     end


    % Comienza la captura de datos
    while true
        % Solicitar estado al dispositivo

        writeline(ser, '?');
        pause(0.15); % Pausar para dar tiempo al dispositivo a responder
        if ser.BytesAvailable > 0
            data = readline(ser);

        else
            continue;
        end

        % Procesar la respuesta del dispositivo
        if contains(data, 'Run')
            % Extraer posiciones y velocidad usando expresiones regulares
            tokens = regexp(data, 'MPos:([\d\.-]+),([\d\.-]+).*FS:([\d\.-]+)', 'tokens');
            
            if ~isempty(tokens)
                pos = str2double(tokens{1});
                % Almacenar la posición X, Y y la velocidad en la matriz salida
                salida(k, :) = [pos(1), pos(2), pos(3)];
                k = k + 1;
            end

        elseif contains(data, 'Idle') && k > 1 && p>height(instruc)
            % Detener grabación si se detecta 'Idle' y se han capturado posiciones
            disp("Paro de grabar");
            stop(recorder1);
            audioData = getaudiodata(recorder1);
            filename = 'myRecording.wav';
            audiowrite(filename, audioData, 44100);
            break;
        end
        flushinput(ser);
        flushoutput(ser);
    end
end
