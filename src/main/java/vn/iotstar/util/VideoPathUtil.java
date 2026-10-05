package vn.iotstar.util;

public final class VideoPathUtil {

    private VideoPathUtil() {
    }

    /**
     * Resolves a local video asset path from videoId without modifying database schema.
     * Uses real videos from assets/videos/.
     * Reuses videos if video count exceeds available video files.
     */
    public static String resolveVideoPath(String videoId) {
        if (videoId == null || videoId.trim().isEmpty()) {
            return "assets/videos/video_01.mp4";
        }

        String id = videoId.trim().toUpperCase();
        switch (id) {
            case "VID001":
                return "assets/videos/video_01.mp4";
            case "VID002":
                return "assets/videos/video_02.mp4";
            case "VID003":
                return "assets/videos/video_03.mp4";
            case "VID004":
                return "assets/videos/video_04.mp4";
            case "VID005":
                return "assets/videos/video_05.mp4";
            case "VID006":
                return "assets/videos/video_06.mp4";
            case "VID007":
                return "assets/videos/video_07.mp4";
            case "VID008":
                return "assets/videos/video_08.mp4";
            case "VID009":
                return "assets/videos/video_09.mp4";
            case "VID010":
                return "assets/videos/video_10.mp4";
            case "VID011":
                return "assets/videos/video_11.mp4";
            case "VID012":
                return "assets/videos/video_12.mp4";
            case "VID013":
                return "assets/videos/video_13.mp4";
            case "VID014":
                return "assets/videos/video_01.mp4";
            case "VID015":
                return "assets/videos/video_02.mp4";
            case "VID016":
                return "assets/videos/video_03.mp4";
            default:
                int hash = Math.abs(id.hashCode());
                int index = (hash % 13) + 1;
                return String.format("assets/videos/video_%02d.mp4", index);
        }
    }
}
