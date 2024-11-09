package Clases;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "Detalle")
public class Detalle {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private int pedido_id;
	private int producto_id;
	private int unidades;
	private double preciounidad;
	private double impuesto;
	private double total;
	
	public Detalle() {
	}
	
	public Detalle(int pedido_id, int producto_id, int unidades, double preciounidad, double impuesto, double total) {
		this.pedido_id = pedido_id;
		this.producto_id = producto_id;
		this.unidades = unidades;
		this.preciounidad = preciounidad;
		this.impuesto = impuesto;
		this.total = total;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPedido_id() {
		return pedido_id;
	}
	public void setPedido_id(int pedido_id) {
		this.pedido_id = pedido_id;
	}
	public int getProducto_id() {
		return producto_id;
	}
	public void setProducto_id(int producto_id) {
		this.producto_id = producto_id;
	}
	public int getUnidades() {
		return unidades;
	}
	public void setUnidades(int unidades) {
		this.unidades = unidades;
	}
	public double getPreciounidad() {
		return preciounidad;
	}
	public void setPreciounidad(double preciounidad) {
		this.preciounidad = preciounidad;
	}
	public double getImpuesto() {
		return impuesto;
	}
	public void setImpuesto(double impuesto) {
		this.impuesto = impuesto;
	}
	public double getTotal() {
		return total;
	}
	public void setTotal(double total) {
		this.total = total;
	}

}
