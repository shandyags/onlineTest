/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80030 (8.0.30)
 Source Host           : localhost:3306
 Source Schema         : file_explorer_yuda

 Target Server Type    : MySQL
 Target Server Version : 80030 (8.0.30)
 File Encoding         : 65001

 Date: 29/01/2025 03:01:37
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for folders
-- ----------------------------
DROP TABLE IF EXISTS `folders`;
CREATE TABLE `folders`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `parent_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_parent`(`parent_id` ASC) USING BTREE,
  CONSTRAINT `fk_parent` FOREIGN KEY (`parent_id`) REFERENCES `folders` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of folders
-- ----------------------------
INSERT INTO `folders` VALUES (1, 'Root Folder', NULL);
INSERT INTO `folders` VALUES (2, 'Documents', 1);
INSERT INTO `folders` VALUES (3, 'Images', 1);
INSERT INTO `folders` VALUES (4, 'Videos', 1);
INSERT INTO `folders` VALUES (5, 'Music', 1);
INSERT INTO `folders` VALUES (6, 'Projects', 1);
INSERT INTO `folders` VALUES (7, 'Personal', 2);
INSERT INTO `folders` VALUES (8, 'Work', 2);
INSERT INTO `folders` VALUES (9, 'Vacations', 3);
INSERT INTO `folders` VALUES (10, 'Family', 3);
INSERT INTO `folders` VALUES (11, 'Movies', 4);
INSERT INTO `folders` VALUES (12, 'Series', 4);
INSERT INTO `folders` VALUES (13, 'Rock', 5);
INSERT INTO `folders` VALUES (14, 'Jazz', 5);

SET FOREIGN_KEY_CHECKS = 1;
