/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Product;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.util.Vector;

/**
 *
 * @author Admin
 */
public class DAOProducts extends DBConnect {

    public Vector<Product> filterByBrand(int brand_id, Vector<Product> vector) {
        Vector<Product> filteredVector = new Vector<>();

        for (Product product : vector) {
            if (product.getBrand_id() == brand_id) {
                filteredVector.add(product);
            }
        }
        return filteredVector;
    }

    public Product getProductById(int id) {
        String sql = "select * from products where product_id = " + id;
        Product product = null;
        try {
            Statement statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = statement.executeQuery(sql);

            while (rs.next()) {
                int product_id = rs.getInt(1);
                String product_name = rs.getString(2);
                double price = rs.getDouble(3);
                int quantity = rs.getInt(4);
                String description = rs.getString(5),
                        image_url = rs.getString(6);
                int brand_id = rs.getInt(7);
                String release_date = rs.getString(8);

                product = new Product(product_id, product_name, price, quantity, description, image_url, brand_id, release_date);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return product;
    }

    public Vector<Product> getProducts(String sql) {
        Vector<Product> vector = new Vector<>();

        try {
            Statement statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = statement.executeQuery(sql);

            while (rs.next()) {
                int product_id = rs.getInt(1);
                String product_name = rs.getString(2);
                double price = rs.getDouble(3);
                int quantity = rs.getInt(4);
                String description = rs.getString(5),
                        image_url = rs.getString(6);
                int brand_id = rs.getInt(7);
                String release_date = rs.getString(8);

                vector.add(new Product(product_id, product_name, price, quantity, description, image_url, brand_id, release_date));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return vector;
    }

    public int insertProduct(Product product) {
        int n = 0;
        String sql = """
                     INSERT INTO [dbo].[products]
                                ([product_name]
                                ,[price]
                                ,[quantity]
                                ,[description]
                                ,[image_url]
                                ,[brand_id]
                                ,[release_date])
                          VALUES
                                (?,?,?,?,?,?,?)""";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, product.getProduct_name());
            ps.setDouble(2, product.getPrice());
            ps.setInt(3, product.getQuantity());
            ps.setString(4, product.getDescription());
            ps.setString(5, product.getImage_url());
            ps.setInt(6, product.getBrand_id());
            ps.setString(7, product.getRelease_date());

            n = ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public int updateProduct(Product product) {
        int n = 0;
        String sql = "UPDATE [dbo].[products]\n"
                + "   SET [product_name] = ?\n"
                + "      ,[price] = ?\n"
                + "      ,[quantity] = ?\n"
                + "      ,[description] = ?\n"
                + "      ,[image_url] = ?\n"
                + "      ,[brand_id] = ?\n"
                + "      ,[release_date] = ?\n"
                + " WHERE product_id = ?";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            //pre.setDataType(index of ?, parameter) index start 1

            pre.setInt(8, product.getProduct_id());
            pre.setString(1, product.getProduct_name());
            pre.setDouble(2, product.getPrice());
            pre.setInt(3, product.getQuantity());
            pre.setString(4, product.getDescription());
            pre.setString(5, product.getImage_url());
            pre.setInt(6, product.getBrand_id());
            pre.setString(7, product.getRelease_date());
            n = pre.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return n;
    }

    public int removeProduct(int id) {
        int n = 0;
        String sql = "delete from products where product_id = " + id;

        try {
            Statement statement = connection.createStatement();
            n = statement.executeUpdate(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public static void main(String[] args) {
        DAOProducts dao = new DAOProducts();
        Vector<Product> vector = dao.getProducts("""
                                                        select top 5 * 
                                                        from products
                                                        order by release_date desc""");
        for (Product product : vector) {
            System.out.println(product);
        }
//        int n = dao.insertProduct(new Product( "demo", 0, 0, "", "", 1, ""));
//        if(n>0){
//            System.out.println("inserted");
//        }
    }
}
