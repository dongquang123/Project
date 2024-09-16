/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Brand;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

/**
 *
 * @author Admin
 */
public class DAOBrands extends DBConnect {

    public Vector<Brand> getBrands(String sql) {
        Vector<Brand> vector = new Vector<>();

        try {
            Statement statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = statement.executeQuery(sql);

            while (rs.next()) {
                int brand_id = rs.getInt(1);
                String brand_name = rs.getString(2);
                
                vector.add(new Brand(brand_id, brand_name));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return vector;
    }
    
    public static void main(String[] args) {
        DAOBrands dao =new DAOBrands();
        Vector<Brand> vector = dao.getBrands("select * from brands");
        for (Brand brand : vector) {
            System.out.println(brand);
        }
    }
}
