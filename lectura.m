function [instrucciones,numinstruciones] = lectura(nombreArchivo)
numinstruciones = 0;


try
    % Abrir el archivo
    archivo = fopen(nombreArchivo, 'r');
    
    % Inicializar una celda para almacenar las instrucciones G-code
    instrucciones = {};
    
    % Leer el archivo línea por línea
    while ~feof(archivo)
        linea = fgetl(archivo); % Leer una línea del archivo
        
        % Eliminar espacios en blanco y comentarios
        linea = strtrim(linea); % Eliminar espacios en blanco al principio y al final
        indiceComentario = strfind(linea, ';'); % Buscar el comentario
        if ~isempty(indiceComentario)
            linea = linea(1:indiceComentario-1); % Eliminar el comentario si existe
        end
        
        % Verificar si la línea contiene instrucciones G-code
        if ~isempty(linea) && strncmp(linea, 'G', 1)
            instrucciones{end+1} = linea; % Almacenar la línea como instrucción G-code
            numinstruciones;
        end
    end
    
    % Cerrar el archivo
    fclose(archivo);
    
catch
    % En caso de error, cerrar el archivo si está abierto
    if exist('archivo', 'var') && ~isempty(archivo) && fopen(archivo) ~= -1
        fclose(archivo);
    end
    error('Error al leer el archivo G-code.');
end

%instruc = char(instrucciones)
end