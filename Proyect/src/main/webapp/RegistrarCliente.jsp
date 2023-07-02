
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page import="entidad.Usuario"%>
<%@ page import="entidad.Clientes"%>
<%@ page import="entidad.Cargo"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Registrar Cliente</title>
<link rel="stylesheet" href="css/style.css">
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
		<div class="m-4" style="height: 500px;">
			<div class="row mb-3">
				<div id="botonesContainer" class="col d-flex gap-2">
					<button class="btn btn-warning" data-bs-toggle="modal"
						data-bs-target="#exampleModal">Agregar</button>
				</div>
				<div class="col">
					<form class="input-group" action="servletclient">
						<input type="hidden" name="ejecutarClientes" value="listar">
						<span class="input-group-text" id="inputGroup-sizing-default">Buscar</span>
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
						<th>DNI</th>
						<th>Telefono</th>
						<th>Correo</th>
						<th>Direccion</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${clientes}" var="x">
						<tr>
							<td>${x.cod_cliente}</td>
							<td>${x.nombre}</td>
							<td>${x.apellidos}</td>
							<td>${x.dni}</td>
							<td>${x.telefono}</td>
							<td>${x.correo}</td>
							<td>${x.direccion}</td>
							<td style="text-align: center;">
								<button class="btn btn-success"
									onclick="abrirModalEditar('${x.cod_cliente}', '${x.nombre}', '${x.apellidos}', '${x.dni}', '${x.telefono}', '${x.correo}', '${x.direccion}')">Editar</button>
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

		<!-- Modal Agregar-->
		<div class="modal fade" id="exampleModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">Registrar
							Clientes</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form action="servletclient" id="" method="post"
							class="needs-validation" novalidate>
							<input type="hidden" name="ejecutarClientes" value="agregar">
							<div class="row g-3">
								<div class="col mb-3">
									<label for="formGroupExampleInput" class="form-label">Nombre</label>
									<input class="form-control" type="text" id="id_nombre"
										name="nombreAgregar" placeholder="Ingresa un nombre"
										required="required">
								</div>
								<div class="col mb-3">
									<label for="formGroupExampleInput" class="form-label">Apellido</label>
									<input class="form-control" type="text" id="id_apellido"
										name="apellidoAgregar" placeholder="Ingresa un apellido"
										required="required">
								</div>
							</div>
							<div class="mb-3">
								<label for="formGroupExampleInput" class="form-label">DNI</label>
								<input type="number" class="form-control"
									placeholder="Ingrese un DNI" aria-label="Username"
									aria-describedby="basic-addon1" name="dniAgregar"
									required="required">
							</div>
							<div class="mb-3">
								<label for="formGroupExampleInput" class="form-label">Telefono</label>
								<div class="input-group">
									<span class="input-group-text" id="basic-addon1">+51</span> <input
										type="number" class="form-control"
										placeholder="Ingrese un numero telefonico"
										aria-label="Username" aria-describedby="basic-addon1"
										name="telefonoAgregar" required="required">
								</div>
							</div>
							<div class="mb-3">
								<label for="formGroupExampleInput" class="form-label">Correo</label>
								<div class="input-group">
									<input type="text" class="form-control"
										placeholder="Ingrese un correo"
										aria-label="Recipient's username"
										aria-describedby="basic-addon2" name="correoAgregar"
										required="required"> <span class="input-group-text"
										id="basic-addon2">@gmail.com</span>
								</div>
							</div>
							<div class="col mb-3">
								<label for="formGroupExampleInput" class="form-label">Direccion</label>
								<input class="form-control" type="text" id="id_nombre"
									name="dirrecionAgregar" placeholder="Ingresa una direccion"
									required="required">
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
						<form action="servletclient" id="" method="post"
							class="needs-validation" novalidate>
							<input type="hidden" name="ejecutarClientes" value="actualizar">
							<div class="mb-3">
								<label for="formGroupExampleInput" class="form-label">Codigo
									Cliente</label> <input id="codigo_id" type="number"
									class="form-control" readonly="readonly"
									name="codigoActualizar">
							</div>
							<div class="row g-3">
								<div class="col mb-3">
									<label for="formGroupExampleInput" class="form-label">Nombre</label>
									<input class="form-control" type="text" id="nombre_id"
										name="nombreAgregar" placeholder="Ingresa un nombre"
										required="required">
								</div>
								<div class="col mb-3">
									<label for="formGroupExampleInput" class="form-label">Apellido</label>
									<input class="form-control" type="text" id="apellido_id"
										name="apellidoAgregar" placeholder="Ingresa un apellido"
										required="required">
								</div>
							</div>
							<div class="mb-3">
								<label for="formGroupExampleInput" class="form-label">DNI</label>
								<input type="number" class="form-control"
									placeholder="Ingrese un DNI" aria-label="Username"
									aria-describedby="basic-addon1" name="dniAgregar" id="dni_id"
									required="required">
							</div>
							<div class="mb-3">
								<label for="formGroupExampleInput" class="form-label">Telefono</label>
								<div class="input-group">
									<span class="input-group-text" id="basic-addon1">+51</span> <input
										type="number" class="form-control"
										placeholder="Ingrese un numero telefonico"
										aria-label="Username" aria-describedby="basic-addon1"
										id="telefonoid" name="telefonoAgregar" required="required">
								</div>
							</div>
							<div class="mb-3">
								<label for="formGroupExampleInput" class="form-label">Correo</label>
								<div class="input-group">
									<input type="text" class="form-control"
										placeholder="Ingrese un correo"
										aria-label="Recipient's username"
										aria-describedby="basic-addon2" name="correoAgregar"
										id="correo_id" required="required"> <span
										class="input-group-text" id="basic-addon2">@gmail.com</span>
								</div>
							</div>
							<div class="col mb-3">
								<label for="formGroupExampleInput" class="form-label">Direccion</label>
								<input class="form-control" type="text" id="direccion_id"
									name="dirrecionAgregar" placeholder="Ingresa una direccion"
									required="required">
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
	<script>
        function showSuccessAlert() {
            var successAlert = document.getElementById("successAlert");
            successAlert.classList.add("ajs-visible");

            setTimeout(function () {
                successAlert.classList.remove("ajs-visible");
            }, 3000);
        }

        function showErrorAlert() {
            var errorAlert = document.getElementById("errorAlert");
            errorAlert.classList.add("ajs-visible");

            setTimeout(function () {
                errorAlert.classList.remove("ajs-visible");
            }, 3000);
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
		function abrirModalEditar(codigo, nombre, apellido, dni, telefono, correo,
				direccion) {
			var codigoInput = document.getElementById('codigo_id');
			var nombreInput = document.getElementById('nombre_id');
			var apellidoInput = document.getElementById('apellido_id');
			var dniInput = document.getElementById('dni_id');
			var telefonoInput = document.getElementById('telefonoid');
			var correoInput = document.getElementById('correo_id');
			var direccionInput = document.getElementById('direccion_id');
			var correoSinDominio = correo.replace(/@.*$/, "");
			var telefonoSinPrefijo = telefono.replace(/^\+51/, "").replace(
					/\s/g, "");

			codigoInput.value = codigo;
			nombreInput.value = nombre;
			apellidoInput.value = apellido;
			dniInput.value = dni;
			telefonoInput.value = telefonoSinPrefijo;
			correoInput.value = correoSinDominio;
			direccionInput.value = direccion;

			var modal = new bootstrap.Modal(document
					.getElementById('modalActualizar'));
			modal.show();
		}
	</script>
	<script>
	$(document).ready(function() {    
	    $('#tablaProductos').DataTable({  
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
	 
	        //para usar los botones   
	        responsive: "true",
	        dom: 'Bfrtilp',       
	        buttons:[
	        	{
					extend:    'pdfHtml5',
					text:      '<i class="fas fa-file-pdf icon-large"></i> ',
					titleAttr: 'Exportar a PDF',
					className: 'btn btn-danger btn-icon d-flex align-items-center me-2 rounded'
				},
				{
					extend:    'excelHtml5',
					text:      '<i class="fas fa-file-excel icon-large"></i> ',
					titleAttr: 'Exportar a Excel',
					className: 'btn btn-success btn-icon d-flex align-items-center me-2 rounded'
				}
				
				],
				initComplete: function() {
				      $('#tablaProductos_wrapper .dt-buttons').appendTo('#botonesContainer');
				      $('.dataTables_info').appendTo('#informacion1');
				      $('.dataTables_paginate').appendTo('#informacion2');
				    }
				        
	    });     
	});
		
		/* FORMULARIOS */
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
	request.getRequestDispatcher("index.jsp").forward(request, response);
	}

	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "0");
	%>

</body>
</html>
