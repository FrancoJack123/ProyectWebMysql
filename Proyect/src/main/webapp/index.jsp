<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8" />
<link rel="icon" type="image/x-icon" href="/assets/logo-vt.svg" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Iniciar Sesión</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
	crossorigin="anonymous">
<link rel="stylesheet" href="alerta/alertify.css">
<link rel="stylesheet" href="alerta/themes/default.css">
</head>

<body>
	<div class="container">
		<div class="d-flex flex-column"
			style="display: flex; align-items: center; justify-content: center; height: 963px">
			<div style="padding-bottom: 15px; text-align: center">
				<h1 class="text-dark fw-bold fs-12" style="margin-bottom: 0px;">Iniciar
					Sesión</h1>
				<p class="text-dark">Llené el formulario para Iniciar Sesion</p>
			</div>
			<div style="width: 440px; height: 270px; padding: 20px"
				class="shadow rounded-4">
				<form action="validar" id="id_form" method="POST"
					class="needs-validation" novalidate>
					<div class="mb-3">
						<label for="formGroupExampleInput" class="form-label">Usuario</label>
						<input class="form-control" type="text" id="id_usuario"
							name="usua" placeholder="Ingresa su nombre de usuario"
							required="required">
					</div>
					<div class="mb-3">
						<label for="formGroupExampleInput" class="form-label">Contraseña</label>
						<input class="form-control" type="password" id="id_contraseña"
							name="contra" placeholder="Ingrese su contraseña"
							required="required">
					</div>
					<div class="mb-3">
						<input type="submit" value="Ingresar" class="btn w-100"
							style="background-color: #1d1b31; color: white;">
					</div>

				</form>
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
</body>
</html>