const currentYear = new Date().getFullYear();

document.getElementById("copyright").innerHTML = `&copy; Copyright <time datetime="${currentYear}">${currentYear}</time> - <em>Todos los derechos reservados.</em>`;