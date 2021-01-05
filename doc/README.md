Cree un blog a partir de un único archivo en orgmode, con toda la potencia de bash.

Conservando el archivo blog.org, con la totalidad del contenido del blog en texto plano y org-bash-blog, en cualquier lugar puedes levantar el blog en segundos.

Ventajas respecto a otro tipo de blogs y objetivos
--------------------------------------------------

*   Aprovechando las ventajas del formato y sintaxis orgmode, tener todo el blog en un único archivo de texto plano, y a partir de este, con un solo clic levantar un blog estático HTML ultraligero y sin base de datos, en cualquier tipo de servidor web o local.
*   Poder ir redactando tus artículos y programarlos para que se publiquen automáticamente
*   Depositar en la carpeta **org**, archivos .org independientes con el nombre de la categoría y con todos los artículos de esa categoría.
*   Si te gusta Markdown, también puedes crear tus artículos en Markdown e importarlos con Org-Bash-Blog

Características del Blog
------------------------

    - Genera el RSS del blog y RSS por categorías
    - Genera página Home, con los cinco últimos artículos publicados
    - Genera página con un índice de la totalidad de los artículos publicados, ordenados por fecha
    - Genera página ordenada tags, de un modo inteligente
    - En cada artículo, sugerencia a otro post de la misma categoría
    - Poder utilizar Google Analytics o similar
    - Añadir fecha de modificación de un artículo
    - Programación de publicación de Post
    - Publicación mediante git
    - Utiliza sintaxis orgmode, podiendo añadir imágenes, tablas, cajetillas de código…
    - También puedes importar artículos en markdown

Ventajas respecto a otro tipo de blogs y objetivos
--------------------------------------------------

*   Aprovechando las ventajas del formato y sintaxis orgmode, tener todo el blog en un único archivo de texto plano, y a partir de este, con un solo clic levantar un blog estático HTML ultraligero para cualquier tipo de servidor web (conservando el archivo blog.org, con la totalidad del contenido del blog en texto plano y Org-Bash-Blog, en cualquier lugar puedes levantar el blog)
*   Poder ir redactando tus artículos y programarlos para que se publiquen automáticamente
*   Depositar en la carpeta **org**, archivos .org independientes con el nombre de la categoría y con todos los post de esa categoría.

Instalación
-----------

Clonaremos el repositorio de Org-Bash-Blog

    git clone https://github.com/uGeek/org-bash-blog.git ; cd org-bash-blog

Instalaremos Org-Bash-Blog en nuestro sistema, actualizaremos la ruta de configuración e intalaremos todos los paquetes necesarios.

    sudo ./org-bash-blog -i

Paquetes necesarios
-------------------

Para el correcto funcionamiento de Org-Bash-Blog, necesitamos instalar los siguientes paquetes. Si has instalado Org-Bash-Blog en tu sistema, no será necesario.

    sudo apt install bash pandoc xml2 wget bc whiptail

Instalar Calcurse si deseas ver los días de publicación de forma gráfica

    sudo apt install calcurse

Si vas a hospedar tu blog en GitHub, GitLab,… Necesitarás también git

    sudo apt install git

Ostras Distribuciones no derivadas de Debian
--------------------------------------------

Si utilizas distribuciones no derivadas de Debian, Org-Bash-Blog funcionará perfectamente, pero es necesario instalar los paquetes:

*   bash
*   pandoc
*   xml2
*   wget
*   bc
*   whiptail
*   calcurse
*   git

Creando la configuración del Blog
---------------------------------

Situados en el directorio donde vamos a construir el blog, donde hemos clonado el repositorio de Org-Bash-Blog y están los archivos **config** y **org-bash-blog**, ejecutaremos el siguiente comando:

    sudo ./org-bash-blog -i

Esto editará de forma automática la ruta del archivo de configuración y configurará la ruta del blog en el archivo de configuración.

Puedes cambiar la ruta del archivo de configuración donde desees

### Configuración manual

Abre con tu editor de texto favorito el archivo _**org-bash-blo**_**g** y busca en las primeras líneas, donde aparece **source.**

Escribe la ruta completa donde está el archivo **config.** Podrías dejarlo dentro de la misma carpeta, pero no es obligatorio.

Edita el archivo **config**, añadiendo todas aquellas variables que aparecen, como la ruta de la carpeta del blog, editor de texto, navegador, etc …

Creando estructura de directorios y el archivo blog.org
-------------------------------------------------------

### Creando estructura de directorios

En el caso que no hubieras clonado el repositorio, este comando creará toda la estructura de directorios

    org-bash-blog -b

### Creando archivo blog.org

En el archivo blog.org, estará todo el contenido del blog. Vamos a crearlo. Si h

    org-bash-blog -f blog.org

En cabecera del archivo **blog.org**, añade el Título del blog, url del blog, Descripción, Palabras clave del blog y autor.

    #+TITLE: Título
    #+LINK: https://miblog.org
    #+DESCRIPTION: Este es mi nuevo blog
    #+KEYWORDS: personal, notas
    #+AUTHOR: angel

Archivo program.org y draft.org
-------------------------------

*   **draft.org**, es una archivo donde iremos creando artículos para un futuro o artículos en sucio.
*   **program.org**, es el archivo donde importaremos los artículos de **draft.org**, podremos **previsualizarlos** en formato .html en nuestro navegador antes de su publicación, añadirá las descripción del artículo para ser publicado en el feed y quedará aquí a la espera programado, esperando el dia y hora de su publicación.

Tanto el archivo **draft.org** como **program.org**, no necesitan la cabecera en la parte superior como el archivo **blog.org.**

**El único requisito importante, todos los Artículos tanto en el archivo blog.org y program.org, tienen que estar en estado TODO**

Vamos a crear los archivos **draft.org** y **program.org.** Entraremos en el directorio `/program` y crearemos los archivos:

    cd program/ ; touch draft.org program.org

Creando el Primer Artículo
--------------------------

Para crear un artículo, es tan sencillo como escribir en tu terminal:

    org-bash-blog -n

**Org-bash-blog** nos hará una serie de preguntas sobre el Artículo a que vamos a crear, como:

*   Título
*   Categoria
*   Etiquetas
*   Nombre de la imagen de referencia en el Post. Ejemplo imagen.jpg
*   La url de esta imagen, si está en un servidor. **Org-bash-blog** descargará la imagen en el directorio `**images-blog/**` y la renombrara con el nombre de imagen que le hemos dado

Si hemos seleccionado **Emacs** como editor de texto, abrirá **Emacs** con el archivo **draft.org.**

En la cabecera, aparecerá la fecha y hora actual, como ejemplo.

**No es necesario añadir la descripción, ya que org-bash-blog lo creará después de forma automática**

Importación desde archivos markdown
-----------------------------------

Si has utilizado otro editor externo y has creado el artículo en un archivo markdown, puedes importarlo a Org-Bash-Blog. Estén donde estén esos archivos ejecuta:

    org-bash-blog -nim archivo.md

Previsualizando el Artículo
---------------------------

Para previsualizar el artículo que hemos creado, tenemos que pasar este del archivo **draft.org** a **program.org**. Para ello tenemos que poner el artículo o artículos que queremos pasar a **program.org** en estado `PROGRAM`. Una vez hayamos especificado este estado, teclearemos el comando:

    org-bash-blog -d

Esto enviará todos los archivos de **draft.org** con estado `PROGRAM` al archivo program.org

En **draft.org**, todos los archivos enviados a **program.org**, no serán borrados, permanecerán en **draft.org** pero pasarán al estado **DONE**.

Previsualizar los Artículos
---------------------------

Para generar archivos html y ver una vista previa de los artículos que están en el archivo **program.org**, utilizaremos la opción **\-w** seguido del archivo **program.org**

    org-bash-blog -w program.org

*   Al salir de la previsualización, **org-bash-blog habrá rellenado la Descripción del Post con las primeras 30 palabras del artículo**
*   Creará una página índice con todos los enlaces a las páginas generadas para la previsualización.
*   Estás páginas serán eliminadas cuando utilicemos la opción **\-p** para programar el artículos.

Programar Artículos
-------------------

Utilizando la opción **\-p**, todos los artículos que estén en **program.org**, serán programados con la fecha y hora que indican.

**Es necesario estar dentro del directorio donde está el archivo program.org para programarlo**.

    org-bash-blog -p

Si la carpeta contenía archivos html de la previsualización anterior, serán eliminados.

Para ver los Artículos que tenemos programados, utilizaremos la opción **\-h** de ayuda. En la parte inferior de la ayuda aparecen todos los archivos programados con su título, fecha y hora.

    org-bash-blog -h

Cuando llegue la fecha y hora, el Artículo programado, org-bash-blog pasará el artículo programado del archivo **program.org** al archivo **blog.org**.

**Cada vez que modifiques el archivo program.org o modifiques una fecha de publicación, tienes que ejecutar** `org-bash-blog -p` **para que org-bash-blog los ordene por fecha para la publicación.**

    org-bash-blog -p

Calendario de Publicaciones
---------------------------

Si deseas ver la programación de los artículos programados mediante un calendario, ejecuta:

    org-bash-blog -cal

Org-Bash-Blog abrirá calcurse y verás los días programados en el calendario con el título seguido de # org-bash-blog

Publicación manual o modificación de Artículo
---------------------------------------------

Si queremos modificar o eliminar algún artículo publicado, lo haremos en el archivo **blog.org**.

Para que el cambio ejecutar este cambio

    org-bash-blog blog.org

**Org-bash-blog** creará todas las páginas .html, index.html, list.html, tag.html y el archivo feed.xml

Publicación en GitHub, GitLab,…
-------------------------------

Si tu blog está en repositorio tipo git, puedes hacer un git push desde cualquier directorio con:

    org-bash-blog -g

Editar draft
------------

Abre el archivo **draft.org** con emacs en modo gráfico.

    org-bash-blog draft

Abre el archivo **draft.org** con emacs en modo terminal

    org-bash-blog draftt

Editar program
--------------

Abre el archivo **program.org** con emacs en modo gráfico.

    org-bash-blog program

Abre el archivo **program.org** con emacs en modo terminal

    org-bash-blog programt

Editar blog
-----------

Abre el archivo **blog.org** con emacs en modo gráfico.

    org-bash-blog blog

Abre el archivo **blog.org** con emacs en modo terminal

    org-bash-blog blogt

Resumen del proceso, creación, programación, publicación de un Artículo
-----------------------------------------------------------------------

draft -> program -> blog

Crea un nuevo artículo en draft

    org-bash-blog -n

Si lo quieres importar desde un archivo markdown

    org-bash-blog -nim archivo.md

Para enviar artículos de draft.org a program.org, cambiamos del estado **TODO** A **PROGRAM** y ejecutamos el comando:

    org-bash-blog -d

Para previsualizarlo y que org-bash-blog añada la descripción del artículo para el feed:

    org-bash-blog -w programa.org

Programa la publicación

    org-bash-blog -p

NOVEDADES

*   Programar los días y horas de las publicaciones
*   Menú para generar el post
*   Muestra de forma gráfica en un calendario los dias de publicación
*   Añade buscador de artículos
*   Auto rellena el nombre de la página html, la descripción del post, ...
*   Descarga imágenes para incrustarlas en el artículos de imágenes en la web
*   Muestra el número de palabras y tiempo de lectura
*   Genera páginas relacionadas por categorías
*   Instalación de paquetes necesarios y autoconfiguración
*   Importanción desde archivos markdown