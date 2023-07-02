<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page import="entidad.Usuario"%>
<%@ page import="entidad.Cargo"%>
<%@ page import="entidad.Categoria"%>
<%@ page import="entidad.Producto"%>
<html>
<head>
<meta http-equiv="Content-Type" content="te	xt/html; charset=UTF-8">
<title>Registrar Menu</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/font-awesome.css">
<!-- Boxiocns CDN Link -->
<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.25/css/dataTables.bootstrap5.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.1/css/bootstrap.min.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.8.2/css/all.css"
	integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay"
	crossorigin="anonymous">
<link rel="stylesheet" href="alerta/alertify.css">
<link rel="stylesheet" href="alerta/themes/default.css">
<style type="text/css">
.btn-icon {
	padding: 7px 10px;
	padding:
}

.icon-large {
	font-size: 22px;
	line-height: 1;
}
</style>
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
		<div class="m-4 d-flex gap-3">
			<div class="col-4">
				<div class="row mb-3">
					<div class="col d-flex">
						<button class="btn btn-warning" data-bs-toggle="modal"
							data-bs-target="#agregarCategoria">Agregar</button>
					</div>
				</div>
				<table id="tablaCategoria"
					class="table table-striped table-bordered">
					<thead>
						<tr>
							<th>Categoria</th>
							<th>Nombre</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${categorias}" var="c">
							<tr>
								<td>${c.cod_categoria}</td>
								<td>${c.nombreCategoria}</td>
								<td class="d-flex justify-content-center">
									<button class="btn btn-success"
										onclick="abrirCategoriaActu('${c.cod_categoria}', '${c.nombreCategoria}')">Editar</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="col">
				<div class="row mb-3">
					<div id="botonesContainer" class="col d-flex gap-2">
						<button class="btn btn-warning" data-bs-toggle="modal"
							data-bs-target="#agregarProducto">Agregar</button>
					</div>
					<div class="col">
						<form class="input-group" action="servletProduct">
							<input type="hidden" name="ejecutar" value="listar"> <span
								class="input-group-text" id="inputGroup-sizing-default">Buscar</span>
							<input type="text" class="form-control"
								aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-default"
								placeholder="Ingrese el nombre del usuario" name="incial">

							<button type="submit" class="btn btn-secondary">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
									fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
				<path
										d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z" />
  				</svg>
							</button>
						</form>
					</div>
				</div>
				<table id="tablaProductos"
					class="table table-striped table-bordered">
					<thead>
						<tr>
							<th>ID Producto</th>
							<th>Categoria</th>
							<th>Nombre</th>
							<th>Stock</th>
							<th>Fecha de Vencimiento</th>
							<th>Precio</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${produc}" var="x">
							<tr>
								<td>${x.codProducto}</td>
								<td>${x.categoria.nombreCategoria}</td>
								<td>${x.nombreProducto}</td>
								<td>${x.stock}</td>	
								<td>${x.fechadeVencimiento}</td>
								<td>${x.precio}</td>
								<td class="d-flex justify-content-center gap-2">
									<button class="btn btn-success"
										onclick="abriModalActuProducto('${x.codProducto}', '${x.categoria.nombreCategoria}', '${x.nombreProducto}', '${x.stock}', '${x.fechadeVencimiento}', '${x.precio}')">Editar</button>
									<button class="btn btn-danger"
										onclick="abrirModalDesactivarProduc('${x.codProducto}')">Desactivar</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div id="table-informacion"
					class="d-flex align-items-center justify-content-between">
					<div id="informacion1" class="mb-2"></div>
					<div id="informacion2" class="mt-2"></div>
				</div>
			</div>
		</div>

		<!-- Modal Registrar Categoria -->
		<div class="modal fade" id="agregarCategoria" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="exampleModalLabel">Registrar
							Categoria</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form action="servletProduct" id="" method="post"
							class="needs-validation" novalidate>
							<input type="hidden" name="ejecutar" value="agregarCateg">
							<div class="col mb-3">
								<label for="formGroupExampleInput" class="form-label">Nombre
									de la categoria</label> <input class="form-control" type="text"
									id="categoriaNombre_id" name="categoriaNombre"
									placeholder="Ingresa el nombre de la categoria"
									required="required">
							</div>
							<div class="modal-footer">
								<button type="submit" class="btn btn-success">Registrar</button>
								<button type="button" class="btn btn-danger"
									data-bs-dismiss="modal">Cerrar</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>

		<!-- Modal Actualizar Categoria -->
		<div class="modal fade" id="actualizarCategoria" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="exampleModalLabel">Actualizar
							Categoria</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form action="servletProduct" id="" method="post"
							class="needs-validation" novalidate>
							<input type="hidden" name="ejecutar" value="actualizarCateg">
							<div class="col mb-3">
								<label for="formGroupExampleInput" class="form-label">Codigo
									de la categoria</label> <input class="form-control" type="number"
									id="categoriaCodigoActu_id" name="categoriaCodigoActu"
									required="required" readonly="readonly">
							</div>
							<div class="col mb-3">
								<label for="formGroupExampleInput" class="form-label">Nombre
									de la categoria</label> <input class="form-control" type="text"
									id="categoriaNombreActu_id" name="categoriaNombreActu"
									placeholder="Ingresa el nombre de la categoria"
									required="required">
							</div>
							<div class="modal-footer">
								<button type="submit" class="btn btn-success">Actualizar</button>
								<button type="button" class="btn btn-danger"
									data-bs-dismiss="modal">Cerrar</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>

		<!-- Modal Registrar Producto -->
		<div class="modal fade" id="agregarProducto" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="exampleModalLabel">Registrar
							Producto</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form action="servletProduct" id="" method="post"
							class="needs-validation" novalidate>
							<input type="hidden" name="ejecutar" value="agregarProd">
							<div class="col mb-3">
								<label for="formGroupExampleInput" class="form-label">Nombre</label>
								<input class="form-control" type="text" id="nombreProductoAgre"
									name="nombreProductoAgre"
									placeholder="Ingresa el nombre del producto"
									required="required">
							</div>
							<div class="col mb-3">
								<label for="formGroupExampleInput" class="form-label">Stock</label>
								<input class="form-control" type="number" id="stockProductoAgre"
									name="stockProductoAgre"
									placeholder="Ingresa el stock del producto" required="required">
							</div>
							<div class="col mb-3">
								<label for="formGroupExampleInput" class="form-label">Fecha
									de Vencimiento</label> <input class="form-control" type="date"
									id="fechaProductoAgre" name="fechaProductoAgre"
									required="required">
							</div>
							<div class="col mb-3">
								<label for="formGroupExampleInput" class="form-label">Precio</label>
								<div class="input-group">
									<span class="input-group-text" id="basic-addon1">S/. </span> <input
										class="form-control" type="number" id="precioProductoAgre"
										name="precioProductoAgre"
										placeholder="Ingresa el precio del producto"
										required="required">
								</div>
							</div>
							<div class="col mb-3">
								<label for="formGroupExampleInput" class="form-label">Categoria</label>
								<select class="form-select" aria-label="Default select example"
									name="categoriaProducAgre" id="categoriaProducAgre_id">
									<c:forEach items="${categorias}" var="c">
										<option value="${c.cod_categoria}">${c.nombreCategoria}</option>
									</c:forEach>
								</select>
							</div>
							<div class="modal-footer">
								<button type="submit" class="btn btn-success">Registrar</button>
								<button type="button" class="btn btn-danger"
									data-bs-dismiss="modal">Cerrar</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>

		<!-- Modal Actualizar Producto -->
		<div class="modal fade" id="actualizarProducto" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="exampleModalLabel">Actualizar
							Producto</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form action="servletProduct" id="" method="post"
							class="needs-validation" novalidate>
							<input type="hidden" name="ejecutar" value="actualizarProduc">
							<div class="col mb-3">
								<label for="formGroupExampleInput" class="form-label">Codigo</label>
								<input class="form-control" type="number"
									id="codigoProductoActu" name="codigoProductoActu"
									placeholder="Ingresa el codigo del producto"
									readonly="readonly" required="required">
							</div>
							<div class="col mb-3">
								<label for="formGroupExampleInput" class="form-label">Nombre</label>
								<input class="form-control" type="text" id="nombreProductoActu"
									name="nombreProductoActu"
									placeholder="Ingresa el nombre del producto"
									required="required">
							</div>
							<div class="col mb-3">
								<label for="formGroupExampleInput" class="form-label">Stock</label>
								<input class="form-control" type="number" id="stockProductoActu"
									name="stockProductoActu"
									placeholder="Ingresa el stock del producto" required="required">
							</div>
							<div class="col mb-3">
								<label for="formGroupExampleInput" class="form-label">Fecha
									de Vencimiento</label> <input class="form-control" type="date"
									id="fechaProductoActu" name="fechaProductoActu"
									required="required">
							</div>
							<div class="col mb-3">
								<label for="formGroupExampleInput" class="form-label">Precio</label>
								<div class="input-group">
									<span class="input-group-text" id="basic-addon1">S/. </span> <input
										class="form-control" type="number" id="precioProductoActu"
										name="precioProductoActu"
										placeholder="Ingresa el precio del producto"
										required="required">
								</div>
							</div>
							<div class="col mb-3">
								<label for="formGroupExampleInput" class="form-label">Categoria</label>
								<select class="form-select" aria-label="Default select example"
									name="categoriaProducActu" id="categoriaProducActu_id">
									<c:forEach items="${categorias}" var="c">
										<option value="${c.cod_categoria}">${c.nombreCategoria}</option>
									</c:forEach>
								</select>
							</div>
							<div class="modal-footer">
								<button type="submit" class="btn btn-success">Actualizar</button>
								<button type="button" class="btn btn-danger"
									data-bs-dismiss="modal">Cerrar</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>

		<!-- Modal Desactivar Producto-->
		<div class="modal fade" id="desactivarProducto" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="exampleModalLabel">Desactivar
							Producto</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form action="servletProduct">
							<input type="hidden" name="ejecutar" value="eliminar"> <label
								for="formGroupExampleInput" class="form-label mb-3">¿Deseas
								desactivar este producto?</label> <input type="hidden" type="text"
								id="codigoEliminarproducto_id" name="codigoEliminarproducto">
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
		
		<script src="alerta/alertify.js"></script>
		<script type="text/javascript">
			function abrirCategoriaActu(codigo, nombre) {
				var codigoCategoria = document
						.getElementById('categoriaCodigoActu_id');
				var nombreCategoria = document
						.getElementById('categoriaNombreActu_id');

				codigoCategoria.value = codigo;
				nombreCategoria.value = nombre;

				var modal = new bootstrap.Modal(document
						.getElementById('actualizarCategoria'));
				modal.show();
			}

			function abriModalActuProducto(codigo, categoria, nombre, stock,
					fechaNacimiento, precio) {
				var codigoProducto = document
						.getElementById('codigoProductoActu');
				var nombreProducto = document
						.getElementById('nombreProductoActu');
				var stockProducto = document
						.getElementById('stockProductoActu');
				var fechaNacimientoProducto = document
						.getElementById('fechaProductoActu');
				var precioProducto = document
						.getElementById('precioProductoActu');

				codigoProducto.value = codigo;
				nombreProducto.value = nombre;
				stockProducto.value = stock;
				fechaNacimientoProducto.value = fechaNacimiento;
				precioProducto.value = precio;

				var categoriaProducto = document
						.getElementById('categoriaProducActu_id');

				var options = categoriaProducto.options;

				for (var i = 0; i < options.length; i++) {
					if (options[i].text === categoria) {
						options[i].selected = true;
						break;
					}
				}

				var modal = new bootstrap.Modal(document
						.getElementById('actualizarProducto'));
				modal.show();
			}

			function abrirModalDesactivarProduc(codigoProd) {
				var codigoProductoDesa = document
						.getElementById('codigoEliminarproducto_id');

				codigoProductoDesa.value = codigoProd;

				var modal = new bootstrap.Modal(document
						.getElementById('desactivarProducto'));
				modal.show();
			}
		</script>

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
													},

													//para usar los botones xD  
													responsive : "true",
													dom : 'Bfrtilp',
													buttons : [
															{
																extend : 'pdfHtml5',
																text : '<i class="fas fa-file-pdf icon-large"></i> ',
																titleAttr : 'Exportar a PDF',
																className : 'btn btn-danger btn-icon d-flex align-items-center me-2 rounded'
															},
															{
																extend : 'excelHtml5',
																text : '<i class="fas fa-file-excel icon-large"></i> ',
																titleAttr : 'Exportar a Excel',
																className : 'btn btn-success btn-icon d-flex align-items-center me-2 rounded'
															}

													],
													initComplete : function() {
														$(
																'#tablaProductos_wrapper .dt-buttons')
																.appendTo(
																		'#botonesContainer');
														$('.dataTables_info')
																.appendTo(
																		'#informacion1');
														$(
																'.dataTables_paginate')
																.appendTo(
																		'#informacion2');
													}
												});
							});
		</script>
		<script>
			$(document)
					.ready(
							function() {
								$('#tablaCategoria')
										.DataTable(
												{
													searching : false,
													lengthChange : false,
													language : {
														"decimal" : "",
														"emptyTable" : "No hay datos disponibles en la tabla",
														"info" : "Mostrando _START_ a _END_ de _TOTAL_",
														"infoEmpty" : "Mostrando 0 a 0 de 0",
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
		response.sendRedirect("index.jsp");
		}

		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "0");
		%>
	
</body>
</html>
