<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="entidad.Usuario"%>
<%@ page import="entidad.Cargo"%>
<%@ page import="entidad.DashboardSemanaCliente"%>
<%@ page import="entidad.DashboardSemanaPedido"%>
<html lang="en" dir="ltr">
<head>
<meta charset="UTF-8">
<title>Dashboard</title>
<link rel="stylesheet" href="css/style.css">
<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css'
	rel='stylesheet'>
<link href='css/estilos.css' rel='stylesheet'>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
	crossorigin="anonymous">
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
			<div class="d-flex gap-5 mb-4">
				<div class="card col" style="width: 18rem;">
					<div class="card-header text-center">Usuarios</div>
					<div class="card-body">
						<div
							class="d-flex gap-5 justify-content-center align-items-center">
							<div>
								<img alt="" src="image/programador.png" width="100" height="100">
							</div>
							<div>
								<div class="row-inline gap-2">
									<div class="col">
										<h6 class="card-subtitle mb-3 text-body-secondary">
											Registrados hoy dia: <strong>${dash.getHoyUsuario()}</strong>
										</h6>
									</div>
									<div class="col">
										<h6 class="card-subtitle mb-3 text-body-secondary">
											Inactivos: <strong>${dash.getUsuarioInactivos()}</strong>
										</h6>
									</div>
									<div class="col">
										<h6 class="card-subtitle mb-2 text-body-secondary">
											Total: <strong>${dash.getUsuarioTotal()}</strong>
										</h6>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="card col" style="width: 18rem;">
					<div class="card-header text-center">Clientes</div>
					<div class="card-body">
						<div
							class="d-flex gap-5 justify-content-center align-items-center">
							<div>
								<img alt="" src="image/kyc.png" width="100" height="100">
							</div>
							<div>
								<div class="row-inline gap-2">
									<div class="col">
										<h6 class="card-subtitle mb-3 text-body-secondary">
											Registrados hoy dia: <strong>${dash.getClienteHoy()}</strong>
										</h6>
									</div>
									<div class="col">
										<h6 class="card-subtitle mb-3 text-body-secondary">
											Inactivos: <strong>${dash.getClienteInactivos()}</strong>
										</h6>
									</div>
									<div class="col">
										<h6 class="card-subtitle mb-2 text-body-secondary">
											Total: <strong>${dash.getClienteTotal()}</strong>
										</h6>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="card col" style="width: 18rem;">
					<div class="card-header text-center">Productos</div>
					<div class="card-body">
						<div
							class="d-flex gap-5 justify-content-center align-items-center">
							<div>
								<img alt="" src="image/productos.png" width="100" height="100">
							</div>
							<div>
								<div class="row-inline gap-2">
									<div class="col">
										<h6 class="card-subtitle mb-3 text-body-secondary">
											Registrados hoy dia: <strong>${dash.getHoyproductos()}</strong>
										</h6>
									</div>
									<div class="col">
										<h6 class="card-subtitle mb-3 text-body-secondary">
											Inactivos: <strong>${dash.getProductosInactivos()}</strong>
										</h6>
									</div>
									<div class="col">
										<h6 class="card-subtitle mb-2 text-body-secondary">
											Total: <strong>${dash.getProductosTotal()}</strong>
										</h6>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="d-flex gap-5">
				<div class="card col-8">
					<div class="card-header">Ventas Realizadas esta Semana</div>
					<div class="card-body" style="height: 600px">
						<canvas id="chart1"></canvas>
					</div>
				</div>
				<div class="card col">
					<div class="card-header">Clientes Registrados esta Semana</div>
					<div class="card-body" style="height: 600px">
						<canvas id="chart2"></canvas>
					</div>
				</div>
			</div>
		</div>

	</section>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script>
		// Configuración del primer gráfico
		var ctx1 = document.getElementById('chart1').getContext('2d');
		var chart1 = new Chart(ctx1, {
			type: 'bar',
			data: {
				labels: ['Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado', 'Dominingo'],
				<%
				DashboardSemanaPedido semaPedi = (DashboardSemanaPedido) request.getAttribute("semanPedi");
			 	%>
				datasets: [{
					label: 'Ventas',
					data: [<%=semaPedi.lunes%>, <%=semaPedi.martes%>, <%=semaPedi.mier%>, <%=semaPedi.jueve%>,<%=semaPedi.vierne%>, <%=semaPedi.sabado%>, <%=semaPedi.domin%>],
					backgroundColor: 'rgba(75, 192, 192, 0.6)',
					borderColor: 'rgba(75, 192, 192, 1)',
					borderWidth: 1
				}]
			},
			options: {
				scales: {
					y: {
						beginAtZero: true
					}
				}
			}
		});

		// Configuración del segundo gráfico
		var ctx2 = document.getElementById('chart2').getContext('2d');
		var chart2 = new Chart(ctx2, {
			 type: 'pie',
			 data: {
				  labels: ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'],
				  <%
					DashboardSemanaCliente sema = (DashboardSemanaCliente) request.getAttribute("seman");
				  %>
				  datasets: [{
				    label: 'Clientes',
				    data: [<%=sema.lunes%>, <%=sema.martes%>, <%=sema.mier%>, <%=sema.jueve%>,<%=sema.vierne%>, <%=sema.sabado%>, <%=sema.domin%>],
				    backgroundColor: [
				      'rgb(255, 99, 132)',
				      'rgb(54, 162, 235)',
				      'rgb(255, 205, 89)',
				      'rgb(75, 192, 192)',
				      'rgb(255, 159, 64)',
				      'rgb(153, 102, 255)',
				      'rgb(0, 128, 0)'
				    ],
				    cutout: 1,
				    hoverOffset: 4
				  }]
			}
		});
	</script>
	<script src="js/script.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
		crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest"
		crossorigin="anonymous"></script>
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
