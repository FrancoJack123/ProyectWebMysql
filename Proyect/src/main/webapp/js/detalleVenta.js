function enviarDatosClientes(idCliente, nombreCliente, apellido, dni) {
	document.getElementById("idCodigo").value = idCliente;
	document.getElementById("nombreCliente").value = nombreCliente;
	document.getElementById("apellidoCliente").value = apellido;
	document.getElementById("dniCliente").value = dni;

	var clienteAccordion = document.getElementById("panelsStayOpen-collapseOne");
	var ProductosAccordion = document.getElementById("panelsStayOpen-collapseTwo");
	var detallePedidoAccordion = document.getElementById("panelsStayOpen-collapseThree");

	// Activar los acordeones
	clienteAccordion.classList.remove("show");
	ProductosAccordion.classList.add("show");
	detallePedidoAccordion.classList.add("show");

	// Desplazar los acordeones hacia arriba para que sean visibles en la pantalla
	clienteAccordion.scrollIntoView({ behavior: 'smooth' });
	ProductosAccordion.scrollIntoView({ behavior: 'smooth' });
	detallePedidoAccordion.scrollIntoView({ behavior: 'smooth' });
}


function enviarDatos(id, nombre, stock, precio) {
	// Asignar valores a los campos en el segundo modal
	document.getElementById("productoID").value = id;
	document.getElementById("productoNombre").value = nombre;
	document.getElementById("productoStock").value = stock;
	document.getElementById("productoPrecio").value = precio;
	document.getElementById("cantidad").value = 1;
	document.getElementById("precioTotal").value = precio * 1;
}

var cantidadInput = document.getElementById("cantidad");
var precioTotalInput = document.getElementById("precioTotal");

cantidadInput.addEventListener("input", function() {
	var cantidad = parseInt(cantidadInput.value);
	var precio = parseFloat(document.getElementById("productoPrecio").value);

	if (!isNaN(cantidad) && !isNaN(precio)) {
		var total = (cantidad * precio).toFixed(2);
		precioTotalInput.value = total;
	} else {
		precioTotalInput.value = "";
	}
});



document.getElementById("agregarProductoBtn").addEventListener("click", function() {

	// Obtener valores de los campos de entrada
	var id = document.getElementById("productoID").value;
	var nombre = document.getElementById("productoNombre").value;
	var stock = document.getElementById("productoStock").value;
	var precio = document.getElementById("productoPrecio").value;
	var cantidad = document.getElementById("cantidad").value;
	var precioTotal = document.getElementById("precioTotal").value;

	if (id === "" || nombre === "" || cantidad === "" || precio === "") {

	} else {
		// Agregar una nueva fila a la tabla con los valores de los campos
		var tablaProductos = document.getElementById("tablaProductosBody");
		var newRow = tablaProductos.insertRow();
		newRow.innerHTML = "<td>" + id + "</td><td>" + nombre + "</td><td>" + cantidad + "</td><td>" + precioTotal + "</td><td><button class='btn btn-danger btn-sm eliminarBTN'>Eliminar</button></td>";

		var sumaPrecios = calcularSumaPrecios(tablaProductosBody);

		document.getElementById("precioTO").value = sumaPrecios;

		// Limpiar los campos de entrada después de agregar la fila
		document.getElementById("productoID").value = "";
		document.getElementById("productoNombre").value = "";
		document.getElementById("productoStock").value = "";
		document.getElementById("productoPrecio").value = "";
		document.getElementById("cantidad").value = "";
		document.getElementById("precioTotal").value = "";
	}

});

function calcularSumaPrecios(tabla) {
	var filas = tabla.getElementsByTagName("tr");
	var suma = 0;

	// Recorrer las filas de la tabla
	for (var i = 0; i < filas.length; i++) {
		var celdaPrecio = filas[i].querySelector("td:nth-child(4)");
		var precio = parseFloat(celdaPrecio.textContent);
		if (!isNaN(precio)) {
			suma += precio;
		}
	}

	return suma.toFixed(2);
}

// Agregar evento a los botones de eliminación de fila
document.addEventListener("click", function(event) {
	if (event.target && event.target.classList.contains("eliminarBTN")) {
		var row = event.target.parentNode.parentNode;
		row.parentNode.removeChild(row);

		var sumaPrecios = calcularSumaPrecios(tablaProductosBody);
		document.getElementById("precioTO").value = sumaPrecios;
	}
});