/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.time.LocalDate;

public class StaffUtil {

    public static String generateStaffCode(String department, String position, String userId) {
        if (department == null || department.isEmpty()
                || position == null || position.isEmpty()
                || userId == null || userId.length() < 4) {
            throw new IllegalArgumentException("Invalid input");
        }

        // Lấy chữ cái đầu
        char depChar = Character.toUpperCase(department.charAt(0));
        char posChar = Character.toUpperCase(position.charAt(0));

        // Lấy 2 số cuối năm hiện tại
        int year = LocalDate.now().getYear();
        String yearSuffix = String.valueOf(year).substring(2);

        // Lấy 4 ký tự cuối userId
        String userSuffix = userId.substring(userId.length() - 4);

        return "" + depChar + posChar + yearSuffix + userSuffix;
    }

    // Test nhanh
    public static void main(String[] args) {
        String staffCode = generateStaffCode("Marketing", "Manager", "U12345678");
        System.out.println(staffCode);  // Output: MM255678 (năm hiện tại là 2025)
    }
}
