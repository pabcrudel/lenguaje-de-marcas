#!/bin/bash

# Verificar si existe el archivo package.json, y si no existe crearlo
if [ ! -f package.json ]; then
    echo "Creando archivo package.json..."
    npm init -y
fi

# Instalar paquetes de UglifyJS y CleanCSS de forma local en el proyecto
if [ ! -d node_modules/uglify-js ] || [ ! -d node_modules/clean-css-cli ]; then
    echo "Instalando paquetes UglifyJS y CleanCSS..."
    npm install --save-dev uglify-js clean-css-cli
fi

# Crear la carpeta "dist" si no existe
if [ ! -d dist ]; then
    echo "Creando la carpeta dist..."
    mkdir dist
fi

# Iterar por cada archivo en el proyecto
for file in $(find . -type f -name '*.js' -o -name '*.css'); do
    # Crear la estructura de carpetas en la carpeta "dist"
    mkdir -p "dist/$(dirname $file)"

    # Minificar los archivos JS y CSS y colocarlos en la carpeta "dist"
    if [ "$file" = *.js ]; then
        echo "Minificando el archivo $file..."
        node_modules/.bin/uglifyjs -o "dist/${file%.js}.min.js" "$file"
    elif [ "$file" = *.css ]; then
        echo "Minificando el archivo $file..."
        node_modules/.bin/cleancss -o "dist/${file%.css}.min.css" "$file"
    fi
done

echo "¡Minificación de archivos finalizada!"
