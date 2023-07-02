package entidad;

import java.util.Date;

public class Producto {
	int codProducto, stock, activo;
	double precio;
	String nombreProducto;
	Date fechadeVencimiento;
	Categoria categoria;
	
	public int getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(int codProducto) {
		this.codProducto = codProducto;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public int getActivo() {
		return activo;
	}
	public void setActivo(int activo) {
		this.activo = activo;
	}
	public double getPrecio() {
		return precio;
	}
	public void setPrecio(double precio) {
		this.precio = precio;
	}
	public String getNombreProducto() {
		return nombreProducto;
	}
	public void setNombreProducto(String nombreProducto) {
		this.nombreProducto = nombreProducto;
	}
	public Date getFechadeVencimiento() {
		return fechadeVencimiento;
	}
	public void setFechadeVencimiento(Date fechadeVencimiento) {
		this.fechadeVencimiento = fechadeVencimiento;
	}
	public Categoria getCategoria() {
		return categoria;
	}
	public void setCategoria(Categoria categoria) {
		this.categoria = categoria;
	}
	
	
}
