/*
 Navicat Premium Data Transfer

 Source Server         : wfsbmall
 Source Server Type    : MySQL
 Source Server Version : 50610
 Source Host           : localhost:3306
 Source Schema         : wfsbmall

 Target Server Type    : MySQL
 Target Server Version : 50610
 File Encoding         : 65001

 Date: 18/06/2024 16:27:42
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `uid` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `goodsid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `number` int(11) NOT NULL,
  PRIMARY KEY (`uid`, `goodsid`) USING BTREE,
  INDEX `goodsid_cartCheck`(`goodsid`) USING BTREE,
  CONSTRAINT `goodsid_cartCheck` FOREIGN KEY (`goodsid`) REFERENCES `goods` (`goodsid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uid_cartCheck` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES ('ZhuangWuJi55', '3001', 1);
INSERT INTO `cart` VALUES ('ZhuangWuJi55', '4001', 1);

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `goodsid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `goodsname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `category` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `introduction` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `price` decimal(5, 2) NULL DEFAULT NULL,
  `picpath` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`goodsid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('1001', '羊毫笔', '笔', '笔头是用山羊毛制成的。羊毫笔比较柔软，吸墨量大，适于写表现圆浑厚实的点画。比狼毫笔经久耐用。此类笔以湖笔为多，价格比较便宜。一般常见的有大楷笔、京提（或称提笔）、联锋、屏锋、顶锋、盖锋、条幅、玉笋、玉兰蕊，京楂等。', 45.00, 'image/goods/1001.jpg');
INSERT INTO `goods` VALUES ('1002', '狼毫笔', '笔', '狼毫，是指用黄鼠狼的尾毛做成的毛笔。如：小楷狼毫。毛笔的一种，用黄鼠狼（鼬鼠）尾部的毛制成，故名。以我国东北产的“关东辽毫”品质最佳。特点是润滑而富有弹性，宜书宜画，以画为主。', 45.00, 'image/goods/1002.jpg');
INSERT INTO `goods` VALUES ('1003', '鸡毫笔', '笔', '鸡毛笔又称为鸡绒笔、鸡毫笔或鸡毛颖，是以鸡毛为原料，经特殊操作而成。鸡毛笔因其性能特软，蔡邕云：“惟笔软则奇怪生焉”，其优点是易于腴和多态，但不易掌握。', 35.00, 'image/goods/1003.jpg');
INSERT INTO `goods` VALUES ('1004', '鼠须笔', '笔', '鼠须笔是毛笔的一种。①以老鼠胡须制作的毛笔。鼠须笔挺健尖锐，与鬃毫相匹敌，今鼠须笔制法已失传。笔店所售鼠须笔，皆以紫毫充当，已名存实亡。', 40.00, 'image/goods/1004.jpg');
INSERT INTO `goods` VALUES ('1005', '兔毫笔', '笔', '兔毫笔，毛笔的一种。以兔毫为主材制成。古时以中山(今属河北)兔肥毫长为佳。兔毫有紫、花白之分，取自兔脊及尾部之紫毫，物罕而贵，用以制笔称“紫毫笔”，笔性软而圆健，若兼花白者，则毫脆而坚劲。', 45.00, 'image/goods/1005.jpg');
INSERT INTO `goods` VALUES ('1006', '紫毫笔', '笔', '紫毫笔乃取野山兔项背之毫制成，因色呈黑紫而得名。南北方之山兔毫坚劲程度亦不同，也有取南北毫合制的。北豪偏软也叫淮兔毫，意为安徽淮北出的，实乃东北出的较好，现在濒临绝种了，本来也出的少。', 40.00, 'image/goods/1006.jpg');
INSERT INTO `goods` VALUES ('1007', '宣笔', '笔', '宣笔产于安徽省宣城市泾县(原属宁国府，产纸以府治宣城为名，故称“宣笔”)，是中国四大名笔之一。据韩愈《毛颖传》记载，公元前二三年，秦将军蒙恬南下时途经中山（安徽省泾县一带山区）发现这里兔肥毫长，便以竹为管，在原始的竹笔基础上制成改良毛笔。盛行于唐、宋，均有制笔名手。元代以后湖笔渐兴，宣笔渐衰。改革开放后，宣笔渐渐恢复了生机。', 40.00, 'image/goods/1007.jpg');
INSERT INTO `goods` VALUES ('1008', '兼毫笔', '笔', '用几种细毛混合在一起制成的毛笔通常称兼毫笔。制做兼毫笔时，各种毛质的性能、特点的配比要适当，配制的部位要合理，几种毛的长短、含量要准确计算才能达到预期的使用效果，否则失去兼毫笔的定义。', 45.00, 'image/goods/1008.jpg');
INSERT INTO `goods` VALUES ('1009', '0', '笔', '0', 0.00, 'img/goods/0000.jpg');
INSERT INTO `goods` VALUES ('1010', '0', '笔', '0', 0.00, 'img/goods/0000.jpg');
INSERT INTO `goods` VALUES ('2001', '松烟墨', '墨', '松烟墨的制作采用砍伐松枝，烧烟、筛烟、熔胶、杵捣、锤炼等研试而成，工序较为复杂，其特点是浓墨无光，质细易磨。松烟墨要经三冬四夏，还要加许多香料、烟叶等，防虫蛀。', 50.00, 'image/goods/2001.jpg');
INSERT INTO `goods` VALUES ('2002', '油烟墨', '墨', '油烟墨共分四档，油烟101（五石漆烟），油烟102（超贡烟），油烟103（贡烟），油烟104（顶烟）四种。油烟原料都相仿，主要是麝香、冰片等名贵药材、香料的配方不同，油烟101、102还加放适当的金箔，颜色乌黑有光泽，属高级墨，其中以油烟101为最贵。一般书画宜用油烟墨，取其黝黑而有光彩。', 50.00, 'image/goods/2002.jpg');
INSERT INTO `goods` VALUES ('2003', '油松墨', '墨', '墨色浓、有光泽、质量细腻、写出来的字神采焕发，视觉效果好。', 50.00, 'image/goods/2003.jpg');
INSERT INTO `goods` VALUES ('2004', '五彩墨', '墨', '用红、黄、蓝、绿、白五种矿物颜料精制而成，属于高档国画颜料。', 55.00, 'image/goods/2004.jpg');
INSERT INTO `goods` VALUES ('2005', '朱砂墨', '墨', '朱砂墨就是为了适应绘画及圈点批文等实际需要而生产的一种朱红色墨，主要成分就是朱砂。朱砂又称丹砂、辰砂，朱砂的粉末呈红色，可以经久不褪。我国利用朱砂做颜料已有悠久的历史，可追溯到殷商时代。世人所熟悉的甲骨文，“涂朱甲骨”指的就是把朱砂磨成红色粉末，涂嵌在甲骨文的刻痕中以示醒目。古人先是用漆和石粉制成最早期的黑色墨，随着制墨工艺的发展，出现了五彩缤纷的颜色墨，朱砂墨就是颜色墨的一种', 50.00, 'image/goods/2005.jpg');
INSERT INTO `goods` VALUES ('2006', '特烟墨', '墨', '是墨的品种之一。用油烟和选烟掺合起来，加放上等皮胶拌搅，并放入适量麝香、冰片和其他名贵中药香料制成，属高中级墨。', 60.00, 'image/goods/2006.jpg');
INSERT INTO `goods` VALUES ('2007', '选烟墨', '墨', '选烟集绘画、书法、雕刻、造型等艺术于一体，使墨本身成为一种综合性的艺术珍品。徽墨有落纸如漆，色泽黑润，经久不褪，纸笔不胶，香味浓郁，丰肌腻理等特点，素有拈来轻、磨来清、嗅来馨、坚如玉、研无声、一点如漆、万载存真的美誉。', 55.00, 'image/goods/2007.jpg');
INSERT INTO `goods` VALUES ('2008', '漆烟墨', '墨', '漆烟墨墨名。精黑的墨。宋代墨工沈珪以松煤杂脂漆滓烧烟，制成墨，精黑发光，称“漆烟”。参阅宋何薳《墨记·漆烟对胶》。漆烟墨有光亮，宜作画，特点能经久不褪。', 55.00, 'image/goods/2008.jpg');
INSERT INTO `goods` VALUES ('2009', '0', '墨', '0', 0.00, 'img/goods/0000.jpg');
INSERT INTO `goods` VALUES ('2010', '0', '墨', '0', 0.00, 'img/goods/0000.jpg');
INSERT INTO `goods` VALUES ('3001', '宣纸', '纸', '宣纸润墨性好，耐久耐老化强，不易变色。宣纸具有韧而能润、光而不滑、洁白稠密、纹理纯净、搓折无损、润墨性强等特点，有独特的渗透、润滑性能。写字、作画“墨分五色，”即一笔落成，深浅浓淡，纹理可见，墨韵清晰，层次分明。少虫蛀，寿命长。宣纸自古有“纸中之王、千年寿纸”的誉称。', 30.00, 'image/goods/3001.jpg');
INSERT INTO `goods` VALUES ('3002', '生宣纸', '纸', '是宣纸的一种：吸水力强。用淡墨水写时，墨水容易渗入，化开。用浓墨水写则相对容易。故创作书画时，需要掌握好墨的浓淡程度，方可得心应手。', 30.00, 'image/goods/3002.jpg');
INSERT INTO `goods` VALUES ('3003', '熟宣纸', '纸', '生宣纸经上矾、涂色、洒金、印花、涂蜡、洒云母等，就制成了“熟宣”，又叫“素宣”、“矾宣”、“加工宣”。其特点是不洇水，宜于绘制工笔画，能经得住层层皴染，墨和色不会洇散开来。它的缺点是，久藏会出现“漏矾”或脆裂，不适宜作水墨写意画。', 30.00, 'image/goods/3003.jpg');
INSERT INTO `goods` VALUES ('3004', '半生熟宣纸', '纸', '半生熟宣纸是一种具有独特性能的宣纸类型，其特性介于生宣和熟宣之间。半生熟宣纸具有一定的吸水性，但吸水性并不如生宣那么强。墨液可以洇透纸面，但洇的速度相对较慢，这使得在写字或绘画时可以更好地控制字体结构和线条的流畅性。', 35.00, 'image/goods/3004.jpg');
INSERT INTO `goods` VALUES ('3005', '毛太纸', '纸', '毛太纸亦称南毛太纸，仿宋纸，原产于江西，福建、浙江、都有出产。颜色浅黄，性能与毛边纸相仿，但纸幅较小，略薄。性质柔和，厚薄粗细稍有不匀，有明显的帘纹。因纸面清洁、光滑，清代中期以后用以印书的较多。毛太纸吸水性强可作书画纸或书画衬纸，也用作鞭炮纸，毛太纸是修补旧书的必备纸张，补、镶、裱托竹纸书均很相宜。染色后也可以作为旧纸的代用品。', 30.00, 'image/goods/3005.jpg');
INSERT INTO `goods` VALUES ('3006', '竹纸', '纸', '竹纸是以竹子为原材料造的纸，是古代中国人的发明，同时造纸术也是中国古代四大发明之一，古人用竹子造纸书写文章，代替竹简。', 35.00, 'image/goods/3006.jpg');
INSERT INTO `goods` VALUES ('3007', '白麻纸', '纸', '白麻纸：洁白光滑，背面较正面粗糙且有草棍等粘附，质地细薄，坚韧，纸纹均宽，约一指半。', 30.00, 'image/goods/3007.jpg');
INSERT INTO `goods` VALUES ('3008', '黄麻纸', '纸', '色略黄，稍粗糙，有的较白麻纸略厚。白麻纸入潢即成为黄麻纸，可以驱虫，是我国最早的染色纸。', 30.00, 'image/goods/3008.jpg');
INSERT INTO `goods` VALUES ('3009', '麻布纹纸', '纸', '这类麻纸表面可能具有类似于麻布的纹理特征。', 30.00, 'image/goods/3009.jpg');
INSERT INTO `goods` VALUES ('3010', '0', '纸', '0', 0.00, 'img/goods/0000.jpg');
INSERT INTO `goods` VALUES ('4001', '歙砚', '砚', '歙砚，全称歙州砚，中国四大名砚之一，歙砚的制作材料被称为歙石或歙砚石，一般需要5-10亿年的地质变化才能形成，其中最适合制砚的是轻度千枚岩化的板岩 [1]。其主要矿物成分为绢云母、石英、黄铁矿、磁黄铁矿、褐铁矿、炭质等。由于其矿物粒度细，微粒石英分布均匀，故有发墨益毫、滑不拒笔、涩不滞笔的效果，受到历代书法家的称赞。造型浑朴，浮雕、浅浮雕、半圆雕等手法是歙砚台的工艺风格和特点。', 80.00, 'image/goods/4001.jpg');
INSERT INTO `goods` VALUES ('4002', '洮砚', '砚', '中国四大名砚之一，与广东端砚、安徽歙砚、澄泥砚齐名，并称中国四大名砚。洮砚的生产距今已有1300多年的历史。产于甘肃省甘南州卓尼县洮砚乡。洮砚以其石色碧绿、雅丽珍奇、质坚而细、晶莹如玉、扣之无声、呵之可出水珠、发墨快而不损毫、储墨久而不干涸的特点饮誉海内外，历来为宫廷雅室的珍品，文人墨客的瑰宝，馈赠亲友的佳礼，古玩库存中的奇葩。', 80.00, 'image/goods/4002.jpg');
INSERT INTO `goods` VALUES ('4003', '绿洮砚', '砚', '石质腻润，色泽细丽，多为绿色，水纹奇幻。包括“鸭头绿”、“鹦哥绿”、“柳叶青”、“鸊鹈血”等。这些品种的主色调为绿色，但各有其独特的色彩变化和纹理特征。', 80.00, 'image/goods/4003.jpg');
INSERT INTO `goods` VALUES ('4004', '红洮砚', '砚', '呈土红色，色纯而细润，较为罕见。红洮石的颜色独特，为洮砚中的珍品。\r\n\r\n', 80.00, 'image/goods/4004.jpg');
INSERT INTO `goods` VALUES ('4005', '紫端砚', '砚', '紫端石为含有丰富铝、钾、铁的硅酸盐类岩石，主要矿物是粘土矿物类的水白云母以及由水白云母变质的绢云母。其主要特点是石纹丰富，有青花纹、朱砂钉、五彩钉等，并可能含有形似动物眼睛的“石眼”。', 80.00, 'image/goods/4005.jpg');
INSERT INTO `goods` VALUES ('4006', '绿端砚', '砚', '绿端砚是端砚名坑之一，砚石色泽青绿，微带黄色，石质幼嫩，润滑。上等的绿端砚石色泽、石质纯净，一片青绿，晶莹无瑕，在端砚中是较名贵而难得的一种砚石。', 80.00, 'image/goods/4006.jpg');
INSERT INTO `goods` VALUES ('4007', '澄泥砚', '砚', '澄泥砚是中国传统工艺品之一，传统书法用具之一，始于汉，盛于唐宋，迄今已有千余年历史。澄泥砚由于使用经过澄洗的细泥作为原料加工烧制而成，因此澄泥砚质地细腻，犹如婴儿皮肤一般，而且具有贮水不涸，历寒不冰，发墨而不损毫，滋润胜水可与石质佳砚相媲美的特点，因此前人多有赞誉。今日所见古澄泥砚极为稀少，上品更是难求。', 70.00, 'image/goods/4007.jpg');
INSERT INTO `goods` VALUES ('4008', '规格端砚', '砚', '指的是具有特定尺寸和形状规格的端砚。这些砚台不仅具有实用性，还富有艺术性和个性化特点。无论是用于书法、绘画还是收藏鉴赏，规格端砚都是不可多得的珍品。在选择规格端砚时，可以根据个人需求和喜好进行挑选。', 75.00, 'image/goods/4008.jpg');
INSERT INTO `goods` VALUES ('4009', '异形端砚', '砚', '随形砚（异形端砚）是根据砚石的自然形态进行设计制作的。并非每一块砚石都能制作成随形砚，它必须符合审美的意味和观赏的情趣，从而增强艺术气息和文化内涵。', 75.00, 'image/goods/4009.jpg');
INSERT INTO `goods` VALUES ('4010', '0', '砚', '0', 0.00, 'img/goods/0000.jpg');

-- ----------------------------
-- Table structure for orderdetail
-- ----------------------------
DROP TABLE IF EXISTS `orderdetail`;
CREATE TABLE `orderdetail`  (
  `orderid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `goodsid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `number` int(11) NOT NULL,
  `tprice` decimal(5, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`orderid`, `goodsid`) USING BTREE,
  INDEX `goodsid_orderDetailCheck`(`goodsid`) USING BTREE,
  CONSTRAINT `goodsid_orderDetailCheck` FOREIGN KEY (`goodsid`) REFERENCES `goods` (`goodsid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orderid_orderDetailCheck` FOREIGN KEY (`orderid`) REFERENCES `orderlist` (`orderid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of orderdetail
-- ----------------------------
INSERT INTO `orderdetail` VALUES ('1718698088689ZhuangWuJi55', '1001', 1, 45.00);
INSERT INTO `orderdetail` VALUES ('1718698100861ZhuangWuJi55', '2001', 1, 50.00);

-- ----------------------------
-- Table structure for orderlist
-- ----------------------------
DROP TABLE IF EXISTS `orderlist`;
CREATE TABLE `orderlist`  (
  `orderid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `uid` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `time` date NULL DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `rname` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `raddress` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `rtelephone` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`orderid`) USING BTREE,
  INDEX `uid_orderCheck`(`uid`) USING BTREE,
  CONSTRAINT `uid_orderCheck` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of orderlist
-- ----------------------------
INSERT INTO `orderlist` VALUES ('1718698088689ZhuangWuJi55', 'ZhuangWuJi55', '2024-06-18', 'finish', 'ZhuangWuJi55', '121212', '12121212121');
INSERT INTO `orderlist` VALUES ('1718698100861ZhuangWuJi55', 'ZhuangWuJi55', '2024-06-18', 'to be finished', 'ZhuangWuJi55', '121212', '12121212121');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `uid` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sex` tinyint(1) NULL DEFAULT NULL COMMENT '0:男 1:女',
  `telephone` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `email` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('ZhuangWuJi55', '93279E3308BDBBEED946FC965017F67A', 0, '12121212121', '121212', '121212@1212');

SET FOREIGN_KEY_CHECKS = 1;
