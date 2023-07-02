package capa_datos;

import java.io.Console;
import java.sql.Connection;
import java.sql.DriverManager;

public class MysqlBDConexion {
	static{
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		}catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	
	public static Connection getConexion(){
		Connection con=null;
		try {
			con=DriverManager.getConnection("jdbc:mysql://localhost/PROYECTO_LP1?useTimezone=true&serverTimezone=UTC","root","");
			System.out.println(con);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}
	
	
		
}
