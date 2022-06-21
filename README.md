# README

# TATETI

En el código se encuentra el backend del juego TaTeTi. Hay dos modelos (User y Board) y dos controladores (users_controller y boards_controller).

## Instalación 

Ejecutar el siguiente comando:

    $ bundle install

Con el siguiente comando se pondrá en marcha el proyecto en el servidor local en el puerto 3000.

    $ rails s 


## Métodos User
### set_token 
Este método genera un token antes de la creación de un nuevo usuario. Una vez creado, se utilizará el mismo token para todo lo requerido.

Métodos Board
empty_board: Este médoto es invocado antes de la creación de un nuevo Board para inicializar los atributos de este con los valores especificados.
set_winner: Este método es utilizado para definir al jugador ganador.
check_winner: Este método es invocado cada vez que un jugador realiza un nuevo movimiento, y comprueba si existe un ganador. Dentro de él hay una constante con todas las posibles posibles posiciones ganadoras. Al invocar este método se comprueba si dentro de el arreglo de movimientos de cada jugador (cells_user1 y cells_user2) existe una coincidencia con la constate de posiciones ganadoras, y si lo existe, se define a ese usuario como ganador.

Métodos application_controller
current_user: Se utiliza para encontrar al usuario actual de acuerdo al token ingresado en los headers. Este current_user es definido en el application_controller ya que ambos controladores van a hacer uso de él.

current_board: Función igual que el current_user pero con la diferencia que en lugar de encontrar el current_board  por su token, lo hace por su id, que es ingresado como un parámetro en la url.

Métodos users_controller
login: Este método recibe como parámetro el nombre de usuario y la contraseña del User. Luego corrobora si este User existe con los atributos recibidos y si es así muestra el token del mismo.

create: Lo primero que se corrobora en este método es si password y password2 son iguales, si no lo son se muestra el mensaje de “Diferent Passwords”.  Y si son iguales crea un nuevo usuario con los atributos recibidos como parámetros (name, password), y muestra todos los atributos del mismo.

currrent: Se utiliza para saber cuál es el User actual.

index: Se utiliza para traer una lista con todos los usuarios existentes

Métodos boards_controller

create: Este método primero verifica si existe un usuario actual, si no existe muestra un mensaje de error, y en caso de que exista crea un nuevo Board asociado al current_user. Además de crear el board, se modifica el valor del atributo inqueue del User (de true a false), para que el mismo usuario no pueda buscar otro juego si acaba de crear uno.

new_game: Primero se define a un player2 como el primer User encontrado en el que su atrubuto inqueue sea true, y luego se fija si existe. Si no existe muestra un mensaje de error, y si existe asocia este player2 al atributo user2 del Board, dejando así el Board con sus dos jugadores.

new_move: Este método define al comienzo una variable row que va a representar el movimiento del jugador, luego corrobora si en el board existe un winner y si es válido el  movimiento que va a realizar el jugador. Si ambas condiciones se cumplen, se realiza el movimiento y se agrega el mismo  a la variable cells_user1 o cells_user2, que va a contener un array con los movimientos de cada jugador.
