<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page import="entidad.Usuario"%>
<%@ page import="entidad.Clientes"%>
<%@ page import="entidad.Cargo"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Registrar Pedidos</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/font-awesome.css">
<!-- Boxiocns CDN Link -->
<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.25/css/dataTables.bootstrap5.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.1/css/bootstrap.min.css">
<link rel="stylesheet" href="alerta/alertify.css">
<link rel="stylesheet" href="alerta/themes/default.css">
</head>
<body>
	<%
	Usuario usuario = (Usuario) session.getAttribute("usuario");
	if (usuario != null) {
	%>

	<div class="sidebar close">
		<div class="logo-details">
			<i class='bx bxl-product-hunt'></i> <span class="logo_name">ProyectoLP</span>
		</div>
		<ul class="nav-links">
			<li><a href="servletdashboa" onclick="redirigirOtraPagina()"> <i class='bx bx-grid-alt'></i>
					<span class="link_name">Dashboard</span>
			</a>
				<ul class="sub-menu blank">
					<li><a class="link_name" href="servletdashboa" onclick="redirigirOtraPagina()">Dashboard</a></li>
				</ul></li>
			<li><a href="servletUsuar?ejecutar=listar&incial=" onclick="redirigirOtraPagina()"> <i
					class='bx bxs-user'></i><span class="link_name"> Usuarios</span>
			</a>
				<ul class="sub-menu blank">
					<li><a class="link_name"
						href="servletUsuar?ejecutar=listar&incial=" onclick="redirigirOtraPagina()">Usuarios</a></li>
				</ul></li>
			<li><a href="servletclient?ejecutarClientes=listar&incial=" onclick="redirigirOtraPagina()">
					<i class='bx bxs-group'></i><span class="link_name">Clientes</span>
			</a>
				<ul class="sub-menu blank">
					<li><a class="link_name"
						href="servletclient?ejecutarClientes=listar&incial=" onclick="redirigirOtraPagina()">Clientes</a></li>
				</ul></li>
			<li><a href="servletProduct?ejecutar=listar&incial=" onclick="redirigirOtraPagina()"> <i
					class='bx bx-archive'></i> <span class="link_name">Productos</span>
			</a>
				<ul class="sub-menu blank">
					<li><a class="link_name"
						href="servletProduct?ejecutar=listar&incial=" onclick="redirigirOtraPagina()">Productos</a></li>
				</ul></li>
			<li><a href="servletUsuar?ejecutar=listarInactivos" onclick="redirigirOtraPagina()"> <i
					class='bx bxs-error-circle'></i> <span class="link_name">Inactivos</span>
			</a>
				<ul class="sub-menu blank">
					<li><a class="link_name"
						href="servletUsuar?ejecutar=listarInactivos" onclick="redirigirOtraPagina()">Inactivos</a></li>
				</ul></li>
			<li><a href="servletpedido?ejecutar=listarNuevo"> <i
					class='bx bx-cart-alt'></i> <span class="link_name"> Pedidos</span>
			</a>
				<ul class="sub-menu blank">
					<li><a class="link_name" href="servletpedido?ejecutar=listarNuevo">
							Pedidos</a></li>
				</ul></li>
			<li><a href="servletpedido?ejecutar=listadoPedido&incial=" onclick="redirigirOtraPagina()"> <i class='bx bxs-report'></i> <span class="link_name"> Reportes</span>
			</a>
				<ul class="sub-menu blank">
					<li><a class="link_name" href="servletpedido?ejecutar=listadoPedido&incial=">
							Reportes</a></li>
				</ul></li>
			<li>
				<div class="profile-details">
					<div class="profile-content">
						<img src="image/usuario.png" alt="profileImg">
					</div>
					<div class="name-job">
						<div class="profile_name">${usuario.getNombre()}</div>
						<div class="job">${usuario.getCargo().getNombreCargo()}</div>
					</div>
					<form action="cerrarsesion" method="POST">
						<a href="cerrarsesion"><i class='bx bx-log-out'></i></a>
					</form>
				</div>
			</li>
		</ul>
	</div>
	<section class="home-section">
		<div class="home-content">
			<i class='bx bx-menu'></i> <span class="text">Bienvenido :
				${usuario.getNombre()}</span>
		</div>
		<div class="m-4" style="height: 500px;">
			<div class="accordion" id="accordionPanelsStayOpenExample">
				<div class="accordion-item">
					<h2 class="accordion-header">
						<button class="accordion-button" type="button"
							data-bs-toggle="collapse" data-bs-target="#collapseOne"
							aria-expanded="true" aria-controls="collapseOne">Buscar
							Cliente</button>
					</h2>
					<div id="collapseOne" class="accordion-collapse collapse show"
						data-bs-parent="#accordionExample">
						<div class="accordion-body">
							<form action="servletpedido" method="post">
								<input type="hidden" name="ejecutar" value="ejecutarVenta">
								<div class="row">
									<input type="hidden" class="form-control"
										placeholder="Seleccione" aria-label="Last name" id="idCodigo">
									<div class="col-3">
										<label for="inputEmail4" class="form-label">DNI</label>
										<div class="input-group mb-3">
											<input type="text" class="form-control"
												placeholder="Seleccione" id="dniCliente"
												aria-label="Last name" name="dniCLiente"
												value="${cliente.getDni()}">
											<button class="btn btn-secondary" type="submit"
												id="button-addon2" name="accion" value="buscarClie">Buscar</button>
										</div>
									</div>
									<div class="col">
										<label for="inputEmail4" class="form-label">Nombre</label> <input
											type="text" class="form-control" placeholder="Seleccione"
											id="nombreCliente" aria-label="Last name" readonly="readonly"
											value="${cliente.getNombre()}">
									</div>
									<div class="col">
										<label for="inputEmail4" class="form-label">Apellido</label> <input
											type="text" class="form-control" placeholder="Seleccione"
											aria-label="Last name" id="apellidoCliente"
											readonly="readonly" value="${cliente.getApellidos()}">
									</div>
									<div class="col">
										<label for="inputEmail4" class="form-label">Direccion</label>
										<input type="text" class="form-control"
											placeholder="Seleccione" aria-label="Last name"
											id="apellidoCliente" readonly="readonly"
											value="${cliente.getDireccion()}">
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="accordion-item">
					<h2 class="accordion-header">
						<button class="accordion-button" type="button"
							data-bs-toggle="collapse"
							data-bs-target="#panelsStayOpen-collapseTwo"
							aria-expanded="false" aria-controls="panelsStayOpen-collapseTwo">
							Buscar Producto</button>
					</h2>
					<div id="panelsStayOpen-collapseTwo"
						class="accordion-collapse collapse show">
						<div class="accordion-body">
							<form action="servletpedido" method="post">
								<input type="hidden" name="ejecutar" value="ejecutarVenta">
								<div class="row">
									<div class="col">
										<label for="inputEmail4" class="form-label">ID
											Producto</label>
										<div class="input-group mb-3">
											<input type="text" class="form-control"
												placeholder="Seleccione" aria-label="Last name"
												id="productoID" name="productoCodigo" readonly="readonly">
											<button class="btn btn-secondary" type="button"
												id="button-addon2" data-bs-toggle="modal"
												data-bs-target="#exampleModal">Listar</button>
										</div>
									</div>
									<div class="col-4">
										<label for="inputEmail4" class="form-label">Nombre</label> <input
											type="text" class="form-control" placeholder="Seleccione"
											id="productoNombre" aria-label="Last name"
											name="nameProducto" readonly="readonly">
									</div>
									<div class="col">
										<label for="inputEmail4" class="form-label">Stock</label> <input
											type="text" class="form-control" placeholder="Seleccione"
											id="productoStock" aria-label="Last name" readonly="readonly">
									</div>
									<div class="col">
										<label for="inputEmail4" class="form-label">Precio</label>
										<div class="input-group">
											<span class="input-group-text" id="basic-addon1">S/. </span>
											<input type="text" class="form-control" id="productoPrecio"
												placeholder="Seleccione" aria-label="Last name"
												readonly="readonly" name="precioProducto">
										</div>
									</div>
								</div>
								<div class="row mt-3">
									<div class="col-5">
										<label for="inputEmail4" class="form-label">Cantidad</label> <input
											type="number" class="form-control"
											placeholder="Ingrese la cantidad" aria-label="Last name"
											id="cantidad" name="cantidadProducto">
									</div>
									<div class="col-5">
										<label for="inputEmail4" class="form-label">Total :</label>
										<div class="input-group">
											<span class="input-group-text" id="basic-addon1">S/. </span>
											<input type="text" class="form-control"
												placeholder="Seleccione" aria-label="Last name"
												readonly="readonly" id="precioTotal" name="precioTotalProd">
										</div>
									</div>
									<div class="col">
										<button type="submit" class="btn btn-warning"
											style="margin-top: 30px" name="accion" value="agregarProduc">Agregar</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="accordion-item">
					<h2 class="accordion-header">
						<button class="accordion-button" type="button"
							data-bs-toggle="collapse"
							data-bs-target="#panelsStayOpen-collapseThree"
							aria-expanded="false"
							aria-controls="panelsStayOpen-collapseThree">Detalle
							Venta</button>
					</h2>
					<div id="panelsStayOpen-collapseThree"
						class="accordion-collapse collapse show">
						<div class="accordion-body">
							<input type="hidden" name="detallesCarrito" id="detallesCarrito"
								value="">
							<table id="detalleVenta" class="table table-striped">
								<thead>
									<tr>
										<th scope="col">ID</th>
										<th scope="col">Producto</th>
										<th scope="col">Cantidad</th>
										<th scope="col">Precio</th>
										<th scope="col"></th>
									</tr>
								</thead>
								<tbody id="tablaProductosBody">
									<c:forEach items="${listaventas}" var="x">
										<tr>
											<td>${x.producto.codProducto}</td>
											<td>${x.producto.nombreProducto}</td>
											<td>${x.cantidad}</td>
											<td>${x.precioVenta}</td>
											<td class="col-2 text-center">
												<form action="servletpedido">
													<input type="hidden" name="ejecutar" value="ejecutarVenta">
													<input type="hidden" value="${x.producto.codProducto}"
														name="productoId">
													<button type="submit" class="btn btn-danger text-center"
														name="accion" value="eliminarProducto">Eliminar</button>
												</form>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<form action="servletpedido">
								<input type="hidden" name="ejecutar" value="ejecutarVenta">
								<div class="d-flex justify-content-end align-items-center gap-2">

									<div class="mb-3 d-flex gap-2 align-items-center">
										<label class="col-4 form-label mt-1">Precio Total : </label>
										<div class="input-group">
											<span class="input-group-text" id="basic-addon1">S/. </span>
											<input type="text" class="form-control"
												placeholder="Precio Total" aria-label="Last name"
												id="totalPedcio" readonly="readonly" name="totalPedcio1">
										</div>
									</div>
									<div class="mb-3 d-flex gap-2 align-items-center">
										<button type="submit" class="btn btn-primary" name="accion"
											value="registrarVenta">Registrar</button>
										<button type="button" class="btn btn-danger" onclick="EliminarTodo()">Cancelar</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<form id="idFormElimina" action="servletpedido" method="post">
		<input type="hidden" name="ejecutar" value="ejecutarVenta">
		<input type="hidden" name="accion" value="cancelar">
	</form>
	
	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">Buscar
						Producto</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<table id="tablaProductos"
						class="table table-striped table-bordered">
						<thead>
							<tr>
								<th>ID</th>
								<th>Nombre</th>
								<th>Stock</th>
								<th>Precio</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${produc}" var="x">
								<tr>
									<td>${x.codProducto}</td>
									<td class="col-6">${x.nombreProducto}</td>
									<td>${x.stock}</td>
									<td>${x.precio}</td>
									<td class="col-2 text-center">
										<button class="btn btn-primary text-center"
											onclick="enviar('${x.codProducto}','${x.nombreProducto}','${x.stock}','${x.precio}')">Agregar</button>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Modal Desactivar-->
		<div class="modal fade" id="cancelaPedido" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="exampleModalLabel">Cancelar 
							Pedido</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form action="servletpedido">
							<input type="hidden" name="ejecutar" value="cancelarPedido"> <label
								for="formGroupExampleInput" class="form-label mb-3">¿Deseas
								cancelar este pedido?</label> 
								<input type="hidden" type="text" id="codpedidoCancel" name="codpedidoCancel">
								<input type="hidden" type="text" id="estapedidoCancel" name="estapedidoCancel">
							<div class="modal-footer">
								<button type="submit" class="btn btn-danger">Desactivar</button>
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal">Cerrar</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>

	<%
	String mensaje = (String) request.getSession().getAttribute("MENSAJE");
	String tipo = (String) request.getSession().getAttribute("TIPO");
	if (mensaje != null) {
	%>
	<div class="alertify-notifier ajs-bottom ajs-right">
		<div id="alert" class="ajs-message <%=tipo%>"><%=mensaje%></div>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(document).ready(function() {
			var successAlert = document.getElementById("alert");
			successAlert.classList.add("ajs-visible");
			setTimeout(function() {
				successAlert.classList.remove("ajs-visible");
			}, 3000);
		});
	</script>
	<%
	}
	request.getSession().removeAttribute("MENSAJE");
	request.getSession().removeAttribute("TIPO");
	%>
	<script type="text/javascript">
		function enviar(id, nombre, stock, precio) {
			// Asignar valores a los campos en el segundo modal
			document.getElementById("productoID").value = id;
			document.getElementById("productoNombre").value = nombre;
			document.getElementById("productoStock").value = stock;
			document.getElementById("productoPrecio").value = precio;
			document.getElementById("cantidad").value = 1;
			document.getElementById("precioTotal").value = precio * 1;

			$('#exampleModal').modal('hide')
		}

		var cantidadInput = document.getElementById("cantidad");
		var precioTotalInput = document.getElementById("precioTotal");

		cantidadInput.addEventListener("input",
				function() {
					var cantidad = parseInt(cantidadInput.value);
					var precio = parseFloat(document
							.getElementById("productoPrecio").value);

					if (!isNaN(cantidad) && !isNaN(precio)) {
						var total = (cantidad * precio).toFixed(2);
						precioTotalInput.value = total;
					} else {
						precioTotalInput.value = "";
					}

				});

		function calcularPrecioTotal() {
			var tablaProductos = document.getElementById("tablaProductosBody");
			var filas = tablaProductos.getElementsByTagName("tr");
			var precioTotal = 0;

			for (var i = 0; i < filas.length; i++) {
				var fila = filas[i];
				var celdaPrecio = fila.cells[3];
				var precio = parseFloat(celdaPrecio.innerText);

				if (!isNaN(precio)) {
					precioTotal += precio;
				}
			}

			document.getElementById("totalPedcio").value = precioTotal
					.toFixed(2);
		}

		window.addEventListener("load", calcularPrecioTotal);
	</script>
	<script type="text/javascript">
		function EliminarTodo() {
			var confirmacion = confirm('¿Estás seguro de que deseas cancelar el pedido?');

			if (confirmacion) {
				document.getElementById('idFormElimina').submit();
			}
		}
		function confirmarRedireccion() {
		    var confirmacion = confirm("¿Estás seguro de que deseas abandonar la página? OJo se borrara todo");
		    if (confirmacion) {
		      document.getElementById("idFormElimina").submit();
		    }else {
		        return false;
		    }
		  }

		  function redirigirOtraPagina() {
		    confirmarRedireccion();
		  }
	</script>
	<script src="alerta/alertify.js"></script>
	<script src="jquery/jquery-3.3.1.min.js"></script>
	<script src="popper/popper.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="datatables/Buttons-1.5.6/js/dataTables.buttons.min.js"></script>
	<script src="datatables/JSZip-2.5.0/jszip.min.js"></script>
	<script src="datatables/pdfmake-0.1.36/pdfmake.min.js"></script>
	<script src="datatables/pdfmake-0.1.36/vfs_fonts.js"></script>
	<script src="datatables/Buttons-1.5.6/js/buttons.html5.min.js"></script>
	<script type="text/javascript" src="datatables/datatables.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"
		integrity="sha384-fbbOQedDUMZZ5KreZpsbe1LCZPVmfTnH7ois6mU1QK+m14rQ1l2bGBq41eYeM/fS"
		crossorigin="anonymous"></script>
	<script>
		$(document)
				.ready(
						function() {
							$('#tablaProductos')
									.DataTable(
											{
												lengthChange : false,
												language : {
													"decimal" : "",
													"emptyTable" : "No hay datos disponibles en la tabla",
													"info" : "Mostrando _START_ a _END_ de _TOTAL_ registros",
													"infoEmpty" : "Mostrando 0 a 0 de 0 registros",
													"infoFiltered" : "",
													"infoPostFix" : "",
													"thousands" : ",",
													/*"lengthMenu": "Mostrar _MENU_ registros por página",*/
													"loadingRecords" : "Cargando...",
													"processing" : "Procesando...",
													"search" : "Buscar:",
													"zeroRecords" : "No se encontraron registros coincidentes",
													"paginate" : {
														"first" : "Primero",
														"last" : "Último",
														"next" : "Siguiente",
														"previous" : "Anterior"
													},
													"aria" : {
														"sortAscending" : ": activar para ordenar la columna ascendente",
														"sortDescending" : ": activar para ordenar la columna descendente"
													}
												}
											});
						});
	</script>
	<script src="js/script.js"></script>
	<%
	} else {
	request.getRequestDispatcher("index.jsp").forward(request, response);
	}

	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "0");
	%>

</body>
</html>
