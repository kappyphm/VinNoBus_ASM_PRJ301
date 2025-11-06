
package module.worklog.model.entity;
import java.sql.Timestamp;

public class WorkLog {
    private int workLogId;
    private int tripId;
    private String userId;
    private String role;
    private Timestamp checkinTime;
    private Timestamp checkoutTime;
    private String notes;

    public WorkLog() {
    }

    public WorkLog(int workLogId, int tripId, String userId, String role, Timestamp checkinTime, Timestamp checkoutTime, String notes) {
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

    public void setWorkLogId(int workLogId) {
        this.workLogId = workLogId;
    }

    public int getTripId() {
        return tripId;
    }

    public void setTripId(int tripId) {
        this.tripId = tripId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Timestamp getCheckinTime() {
        return checkinTime;
    }

    public void setCheckinTime(Timestamp checkinTime) {
        this.checkinTime = checkinTime;
    }

    public Timestamp getCheckoutTime() {
        return checkoutTime;
    }

    public void setCheckoutTime(Timestamp checkoutTime) {
        this.checkoutTime = checkoutTime;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
    
}
