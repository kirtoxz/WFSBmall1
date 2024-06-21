package secure;

import java.security.MessageDigest;
//MD5 Java 文件实现了一个简单的工具类，用于对字符串进行 MD5 散列加密
//字符串加密：将任意长度的字符串通过 MD5 算法加密成固定长度（32 个字符）的十六进制字符串。
//数据摘要：生成数据的摘要，用于校验数据是否被篡改。
//MD5 是一种广泛使用的哈希函数，
// 它可以产生一个 128 位（16 字节）的哈希值，通常用一个 32 位的十六进制字符串表示。这种加密方式常用于密码存储、数据完整性校验等场景。
public class MD5 {
    /** 十六进制下数字到字符的映射数组 */
    private final static String[] hexDigits = { "0", "1", "2", "3", "4", "5",
            "6", "7", "8", "9", "a", "b", "c", "d", "e", "f" };

    /**
     * 对字符串进行MD5编码
     * @param originString
     * @return
     */
    public static String encodeByMD5(String originString) {
        if (originString != null){
            try {
//                获取 MD5 摘要实例
                MessageDigest md = MessageDigest.getInstance("MD5");
//                对字符串进行 MD5 加密，得到散列值的字节数组
                byte[] results = md.digest(originString .getBytes());
//                将加密后的字节数组转换为十六进制字符串
                String resultString = byteArrayToHexString(results);
//                将结果转换为大写形式并返回
                return resultString.toUpperCase();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        return null;
    }

    /**
     * 转换字节数组为16进制字串
     *
     * @param b  字节数组
     * @return 十六进制字串
     */
    private static String byteArrayToHexString(byte[] b) {
        StringBuffer resultSb = new StringBuffer();
        for (int i = 0; i < b.length; i++) {
            resultSb.append(byteToHexString(b[i]));
        }
        return resultSb.toString();
    }

    /**
     * 将一个字节转化成16进制形式的字符串
     * @param b
     * @return
     */
    private static String byteToHexString(byte b) {
        int n = b;
        if (n < 0)
            n = 256 + n;
        int d1 = n / 16;
        int d2 = n % 16;
        return hexDigits[d1] + hexDigits[d2];
    }

    public static void main(String[] args) {
        String s1 = "qizhiqiang";
        String s2 = encodeByMD5(s1);
        System.out.println(s2);
    }
}
