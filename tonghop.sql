-- Tổng hợp code mn 

-- REQ -01 
CREATE VIEW view_user_info AS
SELECT user_id, username, email, created_at
FROM users; 

-- REQ -02 
CREATE OR REPLACE VIEW vw_PostStatistics AS
SELECT
    p.post_id,
    p.content AS noi_dung_bai_viet,
    u.username AS ten_nguoi_dang,
    COUNT(DISTINCT l.user_id) AS tong_like,
    COUNT(DISTINCT c.comment_id) AS tong_comment
FROM posts p
JOIN users u ON u.user_id = p.user_id
LEFT JOIN likes l ON l.post_id = p.post_id
LEFT JOIN comments c ON c.post_id = p.post_id
GROUP BY p.post_id, p.content, u.username; 

-- REQ -03 