<%-- 
    Document   : RegistrarUsuarios
    Created on : 1 jun. 2023, 00:13:37
    Author     : Moreno Jack
--%>

<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="entidad.Usuario"%>
<%@ page import="entidad.Cargo"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Registrar Usuarios</title>
<link rel="stylesheet" href="css/style.css">
<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.25/css/dataTables.bootstrap5.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.1/css/bootstrap.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
	crossorigin="anonymous">
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
		<div class="m-4" style="height: 500px;">
			<div class="row mb-3">
				<div class="col">
					<button type="button" class="btn btn-warning"
						data-bs-toggle="modal" data-bs-target="#exampleModal"
						${desactivado}>Agregar</button>
				</div>
				<div class="col">
					<form class="input-group" action="servletUsuar" method="post">
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
			<table id="tablaProductos" class="table table-striped table-bordered">
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
					<c:forEach items="${usuarios}" var="x">
						<tr>
							<td>${x.idUsuario}</td>
							<td>${x.nombre}</td>
							<td>${x.apellidos}</td>
							<td>${x.telefono}</td>
							<td>${x.correo}</td>
							<td>${x.cargo.nombreCargo}</td>
							<td style="text-align: center;">
								<button class="btn btn-success"
									onclick="abrirModalEditar('${x.idUsuario}','${x.nombre}', '${x.apellidos}', '${x.telefono}', '${x.correo}', '${x.cargo.nombreCargo}')"
									${desactivado}>Editar</button>
								<button class="btn btn-danger"
									onclick="abrirModalEliminar('${x.idUsuario}')" ${desactivado}>Desactivar</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<!-- Modal Agregar-->
		<div class="modal fade" id="exampleModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">Registrar
							Usuarios</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form action="servletUsuar" id="" method="post"
							class="needs-validation" novalidate>
							<input type="hidden" name="ejecutar" value="agregar">
							<div class="row g-3">
								<div class="col mb-3">
									<label for="formGroupExampleInput" class="form-label">Nombre</label>
									<input class="form-control" type="text" id="id_nombre"
										name="nombreAgregar" placeholder="Ingresa tu nombre"
										required="required">
								</div>
								<div class="col mb-3">
									<label for="formGroupExampleInput" class="form-label">Apellido</label>
									<input class="form-control" type="text" id="id_nombre"
										name="apellidoAgregar" placeholder="Ingresa tu apellido"
										required="required">
								</div>
							</div>
							<div class="mb-3">
								<label for="formGroupExampleInput" class="form-label">Telefono</label>
								<div class="input-group">
									<span class="input-group-text" id="basic-addon1">+51</span> <input
										type="number" class="form-control"
										placeholder="Ingrese su numero telefonico"
										aria-label="Username" aria-describedby="basic-addon1"
										name="telefonoAgregar" required="required">
								</div>
							</div>
							<div class="mb-3">
								<label for="formGroupExampleInput" class="form-label">Correo</label>
								<div class="input-group">
									<input type="text" class="form-control"
										placeholder="Ingrese su correo"
										aria-label="Recipient's username"
										aria-describedby="basic-addon2" name="correoAgregar"
										required="required"> <span class="input-group-text"
										id="basic-addon2">@gmail.com</span>
								</div>
							</div>
							<div class="mb-3">
								<label for="formGroupExampleInput" class="form-label">Usuario</label>
								<input class="form-control" type="text" id="id_nombre"
									name="usuarioAgregar"
									placeholder="Ingresa tu nombre de usuario" required="required">
							</div>
							<div class="mb-3">
								<label for="formGroupExampleInput" class="form-label">Contraseña</label>
								<input class="form-control" type="password" id="id_nombre"
									name="contrasela" placeholder="Ingresa tu contraseña"
									required="required">
							</div>
							<div class="mb-3">
								<label for="formGroupExampleInput" class="form-label">Cargo</label>
								<select class="form-select" aria-label="Default select example"
									name="cargoAgregar">
									<!--  <option selected disabled value="null">Ingrese su cargo</option>-->
									<option value="1">Administrador</option>
									<option value="2" selected="selected">Empleado</option>
								</select>
							</div>

							<div class="modal-footer">
								<button type="submit" class="btn btn-primary">Agregar</button>
								<button type="button" class="btn btn-danger"
									data-bs-dismiss="modal">Cerrar</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>

		<!-- Modal Actualizar-->
		<div class="modal fade" id="modalActualizar" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">Actualizar
							Usuarios</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form action="servletUsuar" id="" method="post"
							class="needs-validation" novalidate>
							<input type="hidden" name="ejecutar" value="actualizar">
							<div class="mb-3">
								<label for="formGroupExampleInput" class="form-label">Codigo
									Usuario</label> <input id="codigo_id" type="number"
									class="form-control" readonly="readonly"
									name="codigoActualizar">
							</div>
							<div class="row g-3">
								<div class="col mb-3">
									<label for="formGroupExampleInput" class="form-label">Nombre</label>
									<input class="form-control" type="text" id="nombre_id"
										name="nombreActualizar" placeholder="Ingresa tu nombre"
										required="required">
								</div>
								<div class="col mb-3">
									<label for="formGroupExampleInput" class="form-label">Apellido</label>
									<input class="form-control" type="text" id="apellido_id"
										name="apellidoActualizar" placeholder="Ingresa tu apellido"
										required="required">
								</div>
							</div>
							<div class="mb-3">
								<label for="formGroupExampleInput" class="form-label">Telefono</label>
								<div class="input-group">
									<span class="input-group-text" id="basic-addon1">+51</span> <input
										id="telefonoid" type="number" class="form-control"
										placeholder="Ingrese su numero telefonico"
										name="numeroActualizar" required="required">
								</div>
							</div>
							<div class="mb-3">
								<label for="formGroupExampleInput" class="form-label">Correo</label>
								<div class="input-group">
									<input type="text" class="form-control"
										placeholder="Ingrese su correo"
										aria-label="Recipient's username"
										aria-describedby="basic-addon2" name="correoActualizar"
										id="correo_id" required="required"> <span
										class="input-group-text" id="basic-addon2">@gmail.com</span>
								</div>
							</div>
							<div class="mb-3">
								<label for="formGroupExampleInput" class="form-label">Cargo</label>
								<select class="form-select" aria-label="Default select example"
									name="cargoActualizar" id="cargo_id">
									<!--  <option selected disabled value="null">Ingrese su cargo</option>-->
									<option value="1">Administrador</option>
									<option value="2" selected="selected">Empleado</option>
								</select>
							</div>

							<div class="modal-footer">
								<button type="submit" class="btn btn-primary">Actualizar</button>
								<button type="button" class="btn btn-danger"
									data-bs-dismiss="modal">Cerrar</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>

		<!-- Modal Desactivar-->
		<div class="modal fade" id="eliminar" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="exampleModalLabel">Desactivar
							Usuario</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form action="servletUsuar">
							<input type="hidden" name="ejecutar" value="eliminar"> <label
								for="formGroupExampleInput" class="form-label mb-3">¿Deseas
								desactivar este usuario?</label> <input type="hidden" type="text"
								id="codigoEliminar_id" name="nombreEliminar">
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
		function abrirModalEditar(codigo, nombre, apellido, telefono, correo,
				cargo) {
			var codigoInput = document.getElementById('codigo_id');
			var nombreInput = document.getElementById('nombre_id');
			var apellidoInput = document.getElementById('apellido_id');
			var telefonoInput = document.getElementById('telefonoid');
			var correoInput = document.getElementById('correo_id');
			var cargoSelect = document.getElementById('cargo_id');
			var correoSinDominio = correo.replace(/@.*$/, "");
			var telefonoSinPrefijo = telefono.replace(/^\+51/, "").replace(
					/\s/g, "");

			codigoInput.value = codigo;
			nombreInput.value = nombre;
			apellidoInput.value = apellido;
			telefonoInput.value = telefonoSinPrefijo;
			correoInput.value = correoSinDominio;

			if (cargo === 'Administrador') {
				cargoSelect.value = '1';
			} else if (cargo === 'Empleado') {
				cargoSelect.value = '2';
			}

			var modal = new bootstrap.Modal(document
					.getElementById('modalActualizar'));
			modal.show();
		}

		function abrirModalEliminar(codigoProducto) {
			var rellenarcodigoProducto = document
					.getElementById('codigoEliminar_id');
			rellenarcodigoProducto.value = codigoProducto;

			var modal = new bootstrap.Modal(document.getElementById('eliminar'));
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
		
		(() => {
		  'use strict'
		  const forms = document.querySelectorAll('.needs-validation')
		  Array.from(forms).forEach(form => {
		    form.addEventListener('submit', event => {
		      if (!form.checkValidity()) {
		        event.preventDefault()
		        event.stopPropagation()
		      }

		      form.classList.add('was-validated')
		    }, false)
		  })
		})()

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
