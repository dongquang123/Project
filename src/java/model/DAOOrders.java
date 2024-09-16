/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Order;
import entity.Product;
import jakarta.annotation.Generated;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

/**
 *
 * @author Admin
 */
public class DAOOrders extends DBConnect {

    public Vector<Order> getOrders(String sql) {
        Vector<Order> vector = new Vector<>();

        try {
            Statement statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = statement.executeQuery(sql);

            while (rs.next()) {
                int order_id = rs.getInt(1),
                        user_id = rs.getInt(2);
                String status = rs.getString(3),
                        order_date = rs.getString(3);

                vector.add(new Order(order_id, user_id, status, order_date));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return vector;
    }

    public int updateOrder(String status, int item_id) {
        int n = 0;
        String sql = "UPDATE orders\n"
                + "       SET status = ?\n"
                + "       FROM orders o\n"
                + "       JOIN orderItems oi ON o.order_id = oi.order_id\n"
                + "       WHERE oi.item_id = ?";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            //pre.setDataType(index of ?, parameter) index start 1

            pre.setString(1, status);
            pre.setInt(2, item_id);
            n = pre.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return n;
    }

    public int insertOrder(Order order) {
        int n = 0;
        Integer orderID =null;
        String sql = """
                     INSERT INTO [dbo].[orders]
                                           ([user_id]
                                           ,[order_date]
                                           ,[status])
                                     VALUES(?,?,'Processing')""";

        try {
            PreparedStatement ps = connection.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);

            ps.setInt(1,order.getUser_id());
            ps.setString(2,order.getOrder_date());
            n = ps.executeUpdate();
            
            ResultSet rs = ps.getGeneratedKeys();
            if(rs.next()){
                orderID = rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return orderID;
    }

    public static void main(String[] args) {
        DAOOrders dao = new DAOOrders();
        Vector<Order> vector = dao.getOrders("select * from orders");
        for (Order order : vector) {
            System.out.println(order);
        }
    }
}
