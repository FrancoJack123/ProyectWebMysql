<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page import="entidad.Usuario"%>
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
<style>
.table-input {
	border: none;
	background-color: transparent;
	box-shadow: none;
}

.table-input:focus {
	outline: none;
	box-shadow: none;
}

.formu {
	display: flex;
	justify-content: center;
	text-align: center;
}

.center-input {
	text-align: center;
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
					<li><a class="link_name"
						href="servletpedido?ejecutar=listarNuevo"> Pedidos</a></li>
				</ul></li>
			<li><a href="servletpedido?ejecutar=listadoPedido&incial="> <i class='bx bxs-report'></i>
					<span class="link_name"> Reportes</span>
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
					<a href="servletpedido?ejecutar=listar" class="btn btn-primary">Agregar</a>
				</div>
				<div class="col">
					<form class="input-group" action="servletpedido">
					<input type="hidden" name="ejecutar" value="listadoPedido">
						<span class="input-group-text" id="inputGroup-sizing-default">Buscar</span>
						<input type="text" class="form-control"
							aria-label="Sizing example input"
							aria-describedby="inputGroup-sizing-default"
							placeholder="Ingrese el nombre del usuario" name="incial">

						<button type="submit" href="" class="btn btn-secondary">
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
						<th>ID Pedido</th>
						<th>ID Cliente</th>
						<th>Nombre del Cliente</th>
						<th>ID Usuario</th>
						<th>Monto</th>
						<th>Estado</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${listaPed}" var="x">
						<tr>
							<td>${x.codPedido}</td>
							<td>${x.cliente.cod_cliente}</td>
							<td>${x.cliente.nombre}</td>
							<td>${x.usuario.idUsuario}</td>
							<td>${x.monto}</td>
							<td class="text-success">${x.estado}</td>
							<td style="text-align: center;">
								<button class="btn btn-success" onclick="finalizarPed('${x.codPedido}', '${x.estado}')">Finalizar</button>
								<button class="btn btn-danger" onclick="cancelarPedid('${x.codPedido}', '${x.estado}')">Cancelar</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</section>
	
	<!-- Modal Cancelar-->
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
								<button type="submit" class="btn btn-danger">Cancelar</button>
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal">Cerrar</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		
		<!-- Modal Finalizar-->
		<div class="modal fade" id="finalizarPedido" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="exampleModalLabel">Finalizar 
							Pedido</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form action="servletpedido">
							<input type="hidden" name="ejecutar" value="finalizarPedido"> <label
								for="formGroupExampleInput" class="form-label mb-3">¿Deseas
								finalizar este pedido?</label> 
								<input type="hidden" type="text" id="codPedidoFina" name="codPedidoFina">
								<input type="hidden" type="text" id="estapedidofin" name="estapedidofin">
							<div class="modal-footer">
								<button type="submit" class="btn btn-success">Aceptar</button>
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
	<script type="text/javascript">
		function cancelarPedid(id, estado){
			var codigoPedioCanc = document.getElementById('codpedidoCancel');
			var estadoPediCan = document.getElementById('estapedidoCancel');
			codigoPedioCanc.value = id;
			if(estado == "CAN"){
				estadoPediCan.value=2;
			}else if(estado == "FIN"){
				estadoPediCan.value=3;
			}else{
				estadoPediCan.value=1;
			}
			
			var modal = new bootstrap.Modal(document.getElementById('cancelaPedido'));
			modal.show();
		}
		
		function finalizarPed(id, estado){
			var codigoFina = document.getElementById('codPedidoFina');
			var estadoFina = document.getElementById('estapedidofin');
			codigoFina.value = id;
			if(estado == "CAN"){
				estadoFina.value=2;
			}else if(estado == "FIN"){
				estadoFina.value=3;
			}else{
				estadoFina.value=1;
			}
			
			var modal = new bootstrap.Modal(document.getElementById('finalizarPedido'));
			modal.show();
		}
	</script>
	<script src="js/detalleVenta.js"></script>
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
