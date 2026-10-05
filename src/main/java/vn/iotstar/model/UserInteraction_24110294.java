package vn.iotstar.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class UserInteraction_24110294 {
    private String username;
    private String fullname;
    private String videoId;
    private String videoTitle;
    private String actionType;
    private LocalDateTime actionAt;

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }
    public String getVideoId() { return videoId; }
    public void setVideoId(String videoId) { this.videoId = videoId; }
    public String getVideoTitle() { return videoTitle; }
    public void setVideoTitle(String videoTitle) { this.videoTitle = videoTitle; }
    public String getActionType() { return actionType; }
    public void setActionType(String actionType) { this.actionType = actionType; }
    public LocalDateTime getActionAt() { return actionAt; }
    public void setActionAt(LocalDateTime actionAt) { this.actionAt = actionAt; }
    public String getDisplayTime() {
        return actionAt == null ? "" : actionAt.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
    }
}
