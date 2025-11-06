/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module.worklog.model.dto;

import java.sql.Timestamp;

public class WorkLogDTO {

    private int workLogId;
    private int tripId;
    private String userId;
    private String role;
    private Timestamp checkinTime;
    private Timestamp checkoutTime;
    private String notes;

    public WorkLogDTO() {
    }

    public WorkLogDTO(int workLogId, int tripId, String userId, String role, Timestamp checkinTime, Timestamp checkoutTime, String notes) {
        this.workLogId = workLogId;
        this.tripId = tripId;
        this.userId = userId;
        this.role = role;
        this.checkinTime = checkinTime;
        this.checkoutTime = checkoutTime;
        this.notes = notes;
    }

    public int getWorkLogId() {
        return workLogId;
    }

    public int getTripId() {
        return tripId;
    }

    public String getUserId() {
        return userId;
    }

    public String getRole() {
        return role;
    }

    public Timestamp getCheckinTime() {
        return checkinTime;
    }

    public Timestamp getCheckoutTime() {
        return checkoutTime;
    }

    public String getNotes() {
        return notes;
    }
    
    
}
