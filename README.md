# TFG_819524
Aquí se recogen los scripts y funciones de MatLab desarrollados y utilizados durante el TFG.

Las funciones trayectoria_grabacion2.m y lectura.m son 2 funciones que se necesitan para el funcionamiento de los 3 scripts.

lectura.m se encarga de leer el fichero de G-Code donde se contiene la trayectoria a enviar al equipo, desglosa línea por línea el archivo y lo guarda en un formato char-array que posteriormente será utilizado por trayectoria_grabacion2.m para enviarselo al equipo de escaneo.

trayectoria_grabacion2.m se encarga de el envio de la trayacteoria al equipo de escaneo, así como de la monitorización del mismo y de la captura de la grabación.

Los 3 scripts principales se desglosan de la siguiente manera:

mapaspresion.mlx se encarga de la creación de los mapas sonoros y de superponerlo con una imagen real.

mapasfrecuecia.mlx se encarga de la creación de los mapas frecuenciales y de superponerlo con una imagen real, puede realizarse un análisis para la frecuencia que se queira, el scipt pide al usuario que la introduzca.

NAH.mlx incluye la implementación de la Holografía Acustica de Campo Cercano. Se aprovecha de un plano de presión medido (Se obtiene con mapaspresion.mlx) y después lo aplica a un ejemplo ya creado.

Todos los scipts contienen un ejemplo de un altavoz 2 vías que muestran su funcionamiento.
