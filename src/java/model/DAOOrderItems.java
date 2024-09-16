/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Order;
import entity.Order_Item;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

/**
 *
 * @author Admin
 */
public class DAOOrderItems extends DBConnect {

    public Vector<Order_Item> getOrderItems(String sql) {
        Vector<Order_Item> vector = new Vector<>();

        try {
            Statement statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = statement.executeQuery(sql);

            while (rs.next()) {
                int order_id = rs.getInt(1),
                        item_id = rs.getInt(2),
                        product_id = rs.getInt(3),
                        quantity = rs.getInt(4);
                
                vector.add(new Order_Item(order_id, item_id, product_id, quantity));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return vector;
    }
    public int insertOrderItem(Order_Item orderItem) {
        int n = 0;
        String sql = """
                     INSERT INTO [dbo].[orderItems]
                                                ([order_id]
                                                ,[product_id]
                                                ,[quantity])
                                          VALUES(?,?,?)""";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setInt(1,orderItem.getOrder_id());
            ps.setInt (2,orderItem.getProduct_id());
            ps.setInt(3,orderItem.getQuantity());
            n = ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }
    
    public static void main(String[] args) {
        DAOOrderItems dao =new DAOOrderItems();
        Vector<Order_Item> vector = dao.getOrderItems("select * from order_items");
        for (Order_Item order_Item : vector) {
            System.out.println(order_Item);
        }
    }
}
