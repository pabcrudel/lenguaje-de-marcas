const currentYear = new Date().getFullYear();

// Print current year
document.getElementById("copyright").innerHTML = `&copy; Copyright <time datetime="${currentYear}">${currentYear}</time> - <em>Todos los derechos reservados.</em>`;