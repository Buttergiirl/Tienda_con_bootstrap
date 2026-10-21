package my.webapp.producto;

public class Producto {
    private int Id;
    private String Nombre;
    private double Precio;
    private int Stock;

    public Producto(int Id, String Nombre, double Precio, int Stock) {
        this.Id = Id;
        this.Nombre = Nombre;
        this.Precio = Precio;
        this.Stock = Stock;
    }

    public int getId() { return Id; }
    public String getNombre() { return Nombre; }
    public double getPrecio() { return Precio; }
    public int getStock() { return Stock; }

    public void setId(int Id) { this.Id = Id; }
    public void setNombre(String Nombre) { this.Nombre = Nombre; }
    public void setPrecio(double Precio) { this.Precio = Precio; }
    public void setStock(int Stock) { this.Stock = Stock; }
}
