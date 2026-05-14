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
DELIMITER //
CREATE PROCEDURE sp_register_user(
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_email VARCHAR(100)
)
BEGIN
    IF EXISTS (
        SELECT 1
        FROM users
        WHERE email = p_email
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Email đã được sử dụng';

    ELSE
        INSERT INTO users(username, password, email)
        VALUES (p_username, p_password, p_email);

    END IF;
END //
DELIMITER ; 

-- REQ - 04 
CREATE INDEX idx_post_created_at ON Posts (created_at) ; 
DELIMITER //

CREATE PROCEDURE sp_CreatePost(
    IN p_user_id INT,     
    IN p_content TEXT,    
    OUT p_post_id INT    
)
BEGIN
    INSERT INTO Posts (user_id, content)
    VALUES (p_user_id, p_content);
    
    SET p_post_id = LAST_INSERT_ID();
END //

DELIMITER ;

SET @id_moi = 0;
CALL sp_CreatePost(1, 'Đây là bài đăng đầu tiên !', @id_moi);

SELECT @id_moi AS 'ID bài viết vừa tạo';

SELECT * FROM Posts WHERE post_id = @id_moi;

-- REQ - 05 
