/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.User;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import java.sql.PreparedStatement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class DAOUser extends DBConnect {

    public Vector<User> getUsers(String sql) {
        Vector<User> vector = new Vector<>();

        try {
            Statement statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = statement.executeQuery(sql);

            while (rs.next()) {
                int user_id = rs.getInt(1);
                String username = rs.getString(2),
                        password = rs.getString(3),
                        fullname = rs.getString(4),
                        email = rs.getString(5),
                        phone = rs.getString(6),
                        address = rs.getString(7);
                int isAdmin = rs.getInt(8),
                        isBanned = rs.getInt(9);

                vector.add(new User(user_id, username, password, fullname, email, phone, address, isAdmin, isBanned));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return vector;
    }

    public User login(String user, String pass) {
        String sql = "select * from users where username = ? and password = ? ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, user);
            ps.setString(2, pass);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int user_id = rs.getInt(1);
                String username = rs.getString(2),
                        password = rs.getString(3),
                        fullname = rs.getString(4),
                        email = rs.getString(5),
                        phone = rs.getString(6),
                        address = rs.getString(7);
                int isAdmin = rs.getInt(8),
                        isBanned = rs.getInt(9);
                return new User(user_id, username, password, fullname, email, phone, address, isAdmin, isBanned);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public int removeUser(int id) {
        int n = 0;
        String sql = "delete from users where user_id = " + id;

        try {
            ResultSet rs = getData("select * from orders where staff_id = " + id);
            if (rs.next()) {
                return n;
            }

            Statement statement = connection.createStatement();
            n = statement.executeUpdate(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public int banned(int id) {
        int n = 0;
        String sql = "UPDATE [dbo].[users]\n"
                + "   SET \n"
                + "      [isBanned] = 1\n"
                + " WHERE [user_id] = " + id;

        try {
            Statement statement = connection.createStatement();
            n = statement.executeUpdate(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public int Unbanned(int id) {
        int n = 0;
        String sql = "UPDATE [dbo].[users]\n"
                + "   SET \n"
                + "      [isBanned] = 0\n"
                + " WHERE [user_id] = " + id;

        try {
            Statement statement = connection.createStatement();
            n = statement.executeUpdate(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public int Admin(int id) {
        int n = 0;
        String sql = "UPDATE [dbo].[users]\n"
                + "   SET \n"
                + "      [isAdmin] = 1\n"
                + " WHERE [user_id] = " + id;

        try {
            Statement statement = connection.createStatement();
            n = statement.executeUpdate(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public int insertUser(User user) {
        int n = 0;
        String sql = """
                     INSERT INTO [dbo].[users]
                                ([username]
                                ,[password]
                                ,[fullname]
                                ,[email]
                                ,[phone]
                                ,[address]
                                ,[isAdmin]
                                ,[isBanned])
                          VALUES
                                (?,?,?,?,?,?,?,?)""";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFullname());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getAddress());
            ps.setInt(7, 0);
            ps.setInt(8, 0);

            n = ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public int updateUser(User user) {
        int n = 0;
        String sql = "UPDATE [dbo].[users]\n"
                + "   SET [username] = ?\n"
                + "      ,[password] = ?\n"
                + "      ,[fullname] = ?\n"
                + "      ,[email] = ?\n"
                + "      ,[phone] = ?\n"
                + "      ,[address] = ?\n"
                + " WHERE user_id=?";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            //pre.setDataType(index of ?, parameter) index start 1

            pre.setString(1, user.getUsername());
            pre.setString(2, user.getPassword());
            pre.setString(3, user.getFullname());
            pre.setString(4, user.getEmail());
            pre.setString(5, user.getPhone());
            pre.setString(6, user.getAddress());
            pre.setInt(7, user.getUser_id());
            n = pre.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return n;
    }

    public static void main(String[] args) {
        DAOUser dao = new DAOUser();
        Vector<User> vector = dao.getUsers("select * from users");
        for (User user : vector) {
            System.out.println(user);
        }
    }
}
