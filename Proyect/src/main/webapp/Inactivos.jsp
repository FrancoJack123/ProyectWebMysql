<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page import="entidad.Usuario"%>
<%@ page import="entidad.Cargo"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Inactivos</title>
<link rel="stylesheet" href="css/style.css">
<!-- Boxiocns CDN Link -->
<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.25/css/dataTables.bootstrap5.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.1/css/bootstrap.min.css">
<link rel="stylesheet" href="alerta/alertify.css">
<link rel="stylesheet" href="alerta/themes/default.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
		<li><a href="servletdashboa"> <i class='bx bx-grid-alt'></i>
					<span class="link_name">Dashboard</span>
			</a>
				<ul class="sub-menu blank">
					<li><a class="link_name" href="servletdashboa">Dashboard</a></li>
				</ul></li>
			<li><a href="servletUsuar?ejecutar=listar&incial="> <i
					class='bx bxs-user'></i><span class="link_name"> Usuarios</span>
			</a>
				<ul class="sub-menu blank">
					<li><a class="link_name"
						href="servletUsuar?ejecutar=listar&incial=">Usuarios</a></li>
				</ul></li>
			<li><a href="servletclient?ejecutarClientes=listar&incial=">
					<i class='bx bxs-group'></i><span class="link_name">Clientes</span>
			</a>
				<ul class="sub-menu blank">
					<li><a class="link_name"
						href="servletclient?ejecutarClientes=listar&incial=">Clientes</a></li>
				</ul></li>
			<li><a href="servletProduct?ejecutar=listar&incial="> <i
					class='bx bx-archive'></i> <span class="link_name">Productos</span>
			</a>
				<ul class="sub-menu blank">
					<li><a class="link_name"
						href="servletProduct?ejecutar=listar&incial=">Productos</a></li>
				</ul></li>
			<li><a href="servletUsuar?ejecutar=listarInactivos"> <i
					class='bx bxs-error-circle'></i> <span class="link_name">Inactivos</span>
			</a>
				<ul class="sub-menu blank">
					<li><a class="link_name"
						href="servletUsuar?ejecutar=listarInactivos">Inactivos</a></li>
				</ul></li>
			<li><a href="servletpedido?ejecutar=listarNuevo"> <i
					class='bx bx-cart-alt'></i> <span class="link_name"> Pedidos</span>
			</a>
				<ul class="sub-menu blank">
					<li><a class="link_name" href="servletpedido?ejecutar=listarNuevo">
							Pedidos</a></li>
				</ul></li>
			<li><a href="servletpedido?ejecutar=listadoPedido&incial="> <i class='bx bxs-report'></i> <span class="link_name"> Reportes</span>
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
		<div class="m-4">
			<div>
				<div class="navbar bg-secondary-subtle">
					<div class="container-fluid text-secondary-emphasis">
						<h1 class="navbar-brand">Usuarios inactivos</h1>
					</div>
				</div>
				<table id="tablaUsuarios" class="table table-striped table-bordered">
					<thead>
						<tr>
							<th>ID</th>
							<th>Nombre</th>
							<th>Apellidos</th>
							<th>Telefono</th>
							<th>Correo</th>
							<th>Cargo</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${usuarioInactivos}" var="x">
							<tr>
								<td>${x.idUsuario}</td>
								<td>${x.nombre}</td>
								<td>${x.apellidos}</td>
								<td>${x.telefono}</td>
								<td>${x.correo}</td>
								<td>${x.cargo.nombreCargo}</td>
								<td style="text-align: center;">
									<button class="btn btn-success"
										onclick="abrirModalActivarUsuario('${x.idUsuario}')"
										${desactivado}>Activar</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div>
				<div class="navbar bg-secondary-subtle">
					<div class="container-fluid text-secondary-emphasis">
						<h1 class="navbar-brand">Producto inactivos</h1>
					</div>
				</div>
				<table id="tablaProductos"
					class="table table-striped table-bordered">
					<thead>
						<tr>
							<th>ID Producto</th>
							<th>ID Categoria</th>
							<th>Nombre</th>
							<th>Stock</th>
							<th>Fecha de Vencimiento</th>
							<th>Precio</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${productosInactivos}" var="x">
							<tr>
								<td>${x.codProducto}</td>
								<td>${x.categoria.nombreCategoria}</td>
								<td>${x.nombreProducto}</td>
								<td>${x.stock}</td>
								<td>${x.fechadeVencimiento}</td>
								<td>${x.precio}</td>
								<td class="d-flex justify-content-center">
									<button class="btn btn-success"
										onclick="abrirModalActivarProducto('${x.codProducto}', '${x.nombreProducto}', '${x.categoria.nombreCategoria}', '${x.stock}' )">Actualizar
										Stock</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>

		<!-- Modal Activar Usuarios xD-->
		<div class="modal fade" id="activarUsuario" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="exampleModalLabel">Activar
							Usuario</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form action="servletUsuar">
							<input type="hidden" name="ejecutar" value="activar"> <label
								for="formGroupExampleInput" class="form-label mb-3">¿Deseas
								activar este usuario?</label> <input type="hidden" id="codigoactivar_id"
								name="codigoActivar">
							<div class="modal-footer">
								<button type="submit" class="btn btn-success">Activar</button>
								<button type="button" class="btn btn-danger"
									data-bs-dismiss="modal">Cerrar</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>

		<!-- Modal Activar Producto-->
		<div class="modal fade" id="activar" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="exampleModalLabel">Activar
							Producto</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form action="servletProduct">
							<input type="hidden" name="ejecutar" value="activar">
							<div class="mb-3">
								<label for="formGroupExampleInput" class="form-label">Codigo
									Producto</label> <input type="number" class="form-control"
									aria-label="Username" aria-describedby="basic-addon1"
									name="codigoProdcuto" id="codigoProdcuto" required="required"
									readonly="readonly">
							</div>
							<div class="mb-3">
								<label for="formGroupExampleInput" class="form-label">Nombre
									Producto</label> <input type="text" class="form-control"
									aria-label="Username" aria-describedby="basic-addon1"
									name="nombreProdcuto" id="nombreProdcuto" required="required"
									disabled="disabled">
							</div>
							<div class="mb-3">
								<label for="formGroupExampleInput" class="form-label">Categoria
									Producto</label> <input type="text" class="form-control"
									aria-label="Username" aria-describedby="basic-addon1"
									name="categoriaProdcuto" id="categoriaProdcuto"
									required="required" disabled="disabled">
							</div>
							<div class="mb-3">
								<label for="formGroupExampleInput" class="form-label">Stock</label>
								<input type="number" class="form-control" aria-label="Username"
									aria-describedby="basic-addon1" name="stockProdcuto"
									id="stockProdcuto" required="required">
							</div>
							<div class="modal-footer">
								<button type="submit" class="btn btn-success">Activar</button>
								<button type="button" class="btn btn-danger"
									data-bs-dismiss="modal">Cerrar</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
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
	            setTimeout(function () {
	                successAlert.classList.remove("ajs-visible");
	            }, 3000);
			});
		</script>
	<%
	}
	request.getSession().removeAttribute("MENSAJE");
	request.getSession().removeAttribute("TIPO");
	%>
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
		function abrirModalActivarUsuario(codigoUsuario) {
			var rellenarcodigoUsuario = document
					.getElementById('codigoactivar_id');
			rellenarcodigoUsuario.value = codigoUsuario;

			var modal = new bootstrap.Modal(document
					.getElementById('activarUsuario'));
			modal.show();
		}

		function abrirModalActivarProducto(codigoProducto, nombreProducto,
				categoriaProducto, stock) {
			var rellenarcodigoProducto = document
					.getElementById('codigoProdcuto');
			var rellenarnombreProducto = document
					.getElementById('nombreProdcuto');
			var rellenarcategoriaProducto = document
					.getElementById('categoriaProdcuto');
			var rellenarstockProducto = document
					.getElementById('stockProdcuto');

			rellenarcodigoProducto.value = codigoProducto;
			rellenarnombreProducto.value = nombreProducto;
			rellenarcategoriaProducto.value = categoriaProducto;
			rellenarstockProducto.value = stock;

			var modal = new bootstrap.Modal(document.getElementById('activar'));
			modal.show();
		}
	</script>
	<script>
		$(document)
				.ready(
						function() {
							$('#tablaProductos')
									.DataTable(
											{
												searching : false,
												lengthChange : false,
												language : {
													"decimal" : "",
													"emptyTable" : "No hay datos disponibles en la tabla",
													"info" : "Mostrando _START_ a _END_ de _TOTAL_ registros",
													"infoEmpty" : "Mostrando 0 a 0 de 0 registros",
													"infoFiltered" : "(filtrados de _MAX_ registros totales)",
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
	<script>
		$(document)
				.ready(
						function() {
							$('#tablaUsuarios')
									.DataTable(
											{
												searching : false,
												lengthChange : false,
												language : {
													"decimal" : "",
													"emptyTable" : "No hay datos disponibles en la tabla",
													"info" : "Mostrando _START_ a _END_ de _TOTAL_ registros",
													"infoEmpty" : "Mostrando 0 a 0 de 0 registros",
													"infoFiltered" : "(filtrados de _MAX_ registros totales)",
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
