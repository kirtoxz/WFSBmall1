package db;

import org.apache.commons.dbcp2.BasicDataSourceFactory;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

/**
 * 本模块构建了一个DBCP连接池
 * DBCP连接池配置位于config/dbcpconfig.properties中
 */
public class DBCPUtils {
    private static DataSource ds;//定义一个连接池对象
    static{
        try {
//            创建 Properties 对象用于加载配置文件。
            Properties pro = new Properties();
//            加载类路径下的 dbcpconfig.properties 配置文件
            pro.load(DBCPUtils.class.getClassLoader().getResourceAsStream("config/dbcpconfig.properties"));
            ds = BasicDataSourceFactory.createDataSource(pro);//使用配置创建连接池的 DataSource 对象。
        } catch (Exception e) {
            throw new ExceptionInInitializerError("初始化连接错误，请检查配置文件！");
        }
    }


    /**
     * 构造从连接池取出连接的方法
     * @return Connection
     * @throws SQLException
     */
//    提供公共静态方法获取数据库连接
    public static Connection getConnection() throws SQLException {
        return ds.getConnection();
    }

    /**
     * 关闭rs & stmt & conn
     * @param rs ResultSet 这是一个 java.sql.ResultSet 对象的引用，它代表了执行数据库查询后返回的数据集。
     * 当你完成对查询结果的处理后，应该关闭 ResultSet 对象以释放数据库资源。
     * @param stmt Statement
     * 这是一个 java.sql.Statement 对象的引用，它用于执行SQL语句并返回结果。
     * @param conn Connection
     * 这是一个 java.sql.Connection 对象的引用，它代表了与数据库的连接。
     */
//    提供公共静态方法关闭数据库资源
    public static void closeAll(ResultSet rs, Statement stmt, Connection conn){
        if(rs!=null){
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        if(stmt!=null){
            try {
                stmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        if(conn!=null){
            try {
                conn.close();//关闭
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 测试类
     * @param args
     */
    public static void main(String[] args) {
        try {
            System.out.println("对DBCP池进行测试");
//      通过调用 DBCPUtils 类的 getConnection() 方法，从数据库连接池中获取一个数据库连接，并将其赋值给 Connection 类型的变量 con。
            Connection con = DBCPUtils.getConnection();
//      使用获取到的 Connection 对象 con 创建一个 Statement 对象 stmt，Statement 用于执行SQL语句
            Statement stmt = con.createStatement();
//      使用 stmt 对象执行一条SQL查询语句 "SELECT * FROM user"，这条语句的目的是选择 user 表中的所有记录。查询的结果被存储在 ResultSet 对象 rs 中
            ResultSet rs = stmt.executeQuery("SELECT * FROM user");
//            调用 ResultSet 对象的 next() 方法来移动光标到第一条记录。如果光标移动成功，next() 方法返回 true，否则返回 false。
//            这里使用 System.out.println 打印出 next() 方法的返回值，如果打印的是 true，则表示查询结果至少有一条记录
            System.out.println(rs.next());
            closeAll(rs,stmt,con);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}