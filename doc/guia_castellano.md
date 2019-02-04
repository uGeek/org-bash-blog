# Org-bash-blog
Cree un blog a partir de un único archivo en orgmode con emacs y con toda la potencia de bash

## Requisitos 

Linux y tener instalada emacs26 o superior. 

## Características del Blog

- Genera el RSS del blog y RSS por categorías 
- Genera página Home, con los cinco últimos artículos publicados
- Genera página con un índice de la totalidad de los artículos publicados, ordenados por fecha
- Genera página ordenada tags, de un modo inteligente
- En cada artículo, sugerencia a otro post de la misma categoría 
- Poder utilizar Google Analytics o similar 
- Añadir fecha de modificación de un artículo 
- Utilizar sintaxis orgmode y poder añadir imágenes, tablas, cajetillas de código… 

## Blogs que utilizan org-bash-blog 

- <https://ugeek.github.io/blog>
- <https://elblogdelazaro.gitlab.io>
- <https://www.quijotelibre.com>

Si creas tu blog con org-bash-blog, envíame un correo para añadirte a la lista. 

## Ventajas respecto a otro tipo de blogs y objetivos

- Aprovechando las ventajas del formato y sintaxis orgmode, tener todo el blog en un único archivo de texto plano, y a partir de este, con un solo clic levantar un blog estático HTML ultraligero para cualquier tipo de servidor web( conservando el archivo blog.org, con la totalidad del contenido del blog en texto plano y org-bash-blog.sh, en cualquier lugar puedes levantar el blog) 
- Poder ir redactando tus artículos en el mismo blog.org y sólo cambiando el estado a TODO, publicar este artículo. 
- Depositar en la carpeta org, archivos .org independientes con el nombre de la categoría y con todos los post de esta categoría dentro de este archivo, al generar el blog. 

## Creando Artículos 

Después de crear la cabecera del orgmode, añadiremos las  :PROPERTIES: (no dejar una línea en blanco de separación), dónde está toda la información que posteriormente será exportada tanto al artículo como al RSS. 
```
:PROPERTIES:
:TITLE: Titulo del artículo
:EXPORT_FILE_NAME: nombre del fichero html
:DESCRIPTION: Pequeña descripción del artículo
:EXPORT_DATE: Fecha, que servira como emcabezado para el fichero html
:CATEGORY: categoria con la que vas a agrupar los articulos
:TAG: etiquetas del articulo
:END:
```
- :TITLE: Título del post
- :EXPORT_FILE_NAME: será el nombre de la página html, así que no incluir símbolos  extraños. org-bash-blog añadirá un guión entre espacios y eliminará acentos en el caso de haberlos
- :DESCRIPTION: Una descripción breve del artículo que saldrá impresa en el RSS. La descripción tiene que estar en una única línea, si no, dará error. 
- :EXPORT_DATE: añadir la fecha de publicación y ahora, con el siguiente formato:

```:EXPORT_DATE:  20190125 14:00```

La fecha de publicación sería el 25 de enero del 2019 a las 14 horas

Si con el tiempo queremos modificar  un artículo y que quede constancia en el post, añadiremos la fecha de la siguiente manera:

```:EXPORT_DATE: 20190125 14:00 20190214```

La fecha de modificación del artículo será el 14 de febrero de 2019 

- :CATEGORY: tiene que ser solo una palabra y englobar la categoría general. Los artículos relacionados que aparecen a pie de página en cada artículo, los relaciona en función de la categoría. También en la carpeta org, dejará un archivo o orgmode por cada categoría con todos los post de esta misma. 
- :TAG: puede ser una o varias palabras separadas por comas. No importa si hay espacio entre comas. Hay que tener en cuenta que cada palabra nueva que crees en cualquier artículo, se creara un nueva TAG en página de tags. Cada vez que ejecutemos org-bash-blog, utilizará todas las tags creadas en todos los post y buscará en todos los artículos dentro de sus :PROPERTIES:, si aparece esa palabra, la añadirá en el grupo de artículos vinculados a esa TAG. 

## Publicar

Para publicar un post, tenemos que cambiar el estado del post creado en  blog.org a TODO. 

EL archivo **TODO a publicar**, siempre tiene que estar el último en la lista de artículos del blog.org. 

Puedes dejar todos los estados en TODO, para volver a crear todos los archivos html.  De esta manera, las sugerencias con otras páginas relacionadas de la misma categoría se actualizarán. 

## Importante para el correcto funcionamiento

Cosas a tener e cuenta para el buen funcionamiento de org-bash-blog 

- Las 20 primeras líneas, quedan reservadas  para código de exportación HTML(Google analítics, metadatos,…) 
- El archivo o orgmode, siempre debe llamarse blog.org 
- No intercalar post en estado TODO, porque dará error. Todos los post con estado TODO, deben estar en la parte final de la página. 
- No añadir las :PROPERTIES: del post, hasta el momento de publicar. El feed se genera a partir de las :PROPERTIES:
- no utilizar el carácter | en el título del post no las :PROPERTIES:

## Estética del Blog 

Utiliza un css para personalizar la tipografía y diseño del blog. Después de crear el blog, podremos cambiar esa tipografía, y diseño. 

# Configuración 

- blog.org
- org-bash-blog.sh

## blog.org

Siempre el nombre del archivo tiene que ser blog.org.
```
#+TITLE: uGeek - Blog de Tecnología
#+LINK: https://ugeek.github.io/blog
#+DESCRIPTION: Blog de Tecnología, Android, GNU Linux, Servidores, y mucho más. Blog vinculado al Blog del Podcast de uGeek
#+KEYWORDS: GNU, linux, Raspberry, android, domótica
#+AUTHOR: Angel
#+LANGUAGE: es
```



Estos parámetros son muy importantes, ya que son los valores que aparecerán en el feed, así como el nombre de los links de las páginas webs. 

La cabecera del archivo blog.org, incluye:

- \#+TITLE: Título del blog que aparecerá en el título de cada

página generada así como en el feed o rss

- \#+LINK: Enlace raíz donde irá hospedado el blog. A partir de este dato, org-bash-blog creará todos los enlaces de los artículos
- \#+DESCRIPTION: Descripción del blog incluida en el rss
- \#+KEYWORDS: Palabras clave del blog. 
- \#+AUTHOR: Autor
- \#+LANGUAGE: Idioma del blog

Otros datos

- \#+HTML_HEAD: Todo lo que se añada tras esta etiqueta, será código que se incluirá en cabecera del html, entre el <head> y </head>.  Ejem: El código, va el código del css. 
- \#+HTML: Lo que escríbanos tras esta etiqueta, será código que será copiado en el cuerpo de la página html, entre las ètiquetas <body> </body> ejem: El código html del texto del menú, imagen del logo,…. 

También podríamos incluir en el post, mediante esta etiqueta, código embebido a lo largo de este, como vídeos de YouTube, imágenes de servidores, reproductores html, etc… 

## org-bash-blog.sh

- Texto de bienvenida que aparece en la parte superior de la página index.html

```
INDEX=$(echo "Bienvenidos al Blog de uGeek")
```

- Después, de forma automática, salen publicados los 5 últimos artículos publicados. 


- Texto que aparece en la parte central de la página. Página index.html

```
INDEX_NEXT=$(echo "          ")
```

-   .Texto o contenido que aparece antes del pie de página. Todas las páginas. 

```
PIE_WEB=
```

- Logo que aparece

```
LOGO_FEED="ugeek.png"
```

- Añadir Google analítics o cualquier otro código que quieras añadir en todas las páginas generadas

```
GOOGLE_ANALITYCS=
```





