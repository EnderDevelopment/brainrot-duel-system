CREATE TABLE IF NOT EXISTS `duels` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `player_id` int(11) NOT NULL,
    `target_id` int(11) NOT NULL,
    `timestamp` int(11) NOT NULL,
    `status` varchar(20) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;