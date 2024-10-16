-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'tb_tipo_sensores'
-- Cadastra de tipos de sensores. Ex: sendo de umidade, pH, nutrientes
-- ---

DROP TABLE IF EXISTS `tb_tipo_sensores`;
		
CREATE TABLE `tb_tipo_sensores` (
  `id` INTEGER NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NOT NULL,
  `descricao` VARCHAR(250) NULL,
  PRIMARY KEY (`id`)
) COMMENT 'Cadastra de tipos de sensores. Ex: sendo de umidade, pH, nut';

-- ---
-- Table 'tb_coleta_sensores'
-- Coleta dados dos sensores instalados na area de cultivo, um sensor pode coletar dados de unidade diferentes, então essa coleta é por unidade também
-- ---

DROP TABLE IF EXISTS `tb_coleta_sensores`;
		
CREATE TABLE `tb_coleta_sensores` (
  `id` INTEGER NOT NULL AUTO_INCREMENT,
  `data` DATETIME NOT NULL,
  `valor` DOUBLE NOT NULL,
  `id_sensor` INTEGER NOT NULL,
  `id_area_cultivo` INTEGER NOT NULL,
  `unidade` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`)
) COMMENT 'Coleta dados dos sensores instalados na area de cultivo, um ';

-- ---
-- Table 'tb_agendamento_coleta'
-- Agendar quando os sensores efetuam as coletas por tipo
-- ---

DROP TABLE IF EXISTS `tb_agendamento_coleta`;
		
CREATE TABLE `tb_agendamento_coleta` (
  `id` INTEGER NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(250) NULL,
  `express_cron` VARCHAR(8) NOT NULL,
  `id_tipo_sensor` INTEGER NOT NULL,
  PRIMARY KEY (`id`)
) COMMENT 'Agendar quando os sensores efetuam as coletas por tipo';

-- ---
-- Table 'tb_sensores_unidades'
-- Cadastra as unidades que cada sensor coleta. Ex: sensor de nutrientes coleta fósforo (P) e Potássio (K)
-- ---

DROP TABLE IF EXISTS `tb_sensores_unidades`;
		
CREATE TABLE `tb_sensores_unidades` (
  `id` INTEGER NOT NULL AUTO_INCREMENT,
  `id_tipo_sensor` INTEGER NOT NULL,
  `unidade` VARCHAR(10) NOT NULL COMMENT 'ph, p, f, umidade',
  PRIMARY KEY (`id`)
) COMMENT 'Cadastra as unidades que cada sensor coleta. Ex: sensor de n';

-- ---
-- Table 'tb_cultura'
-- cadastro de culturas, soja, milho, etc
-- ---

DROP TABLE IF EXISTS `tb_cultura`;
		
CREATE TABLE `tb_cultura` (
  `id` INTEGER NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`)
) COMMENT 'cadastro de culturas, soja, milho, etc';

-- ---
-- Table 'tb_area_cultivo'
-- Area (espaço) do cultivo de uma cultura
-- ---

DROP TABLE IF EXISTS `tb_area_cultivo`;
		
CREATE TABLE `tb_area_cultivo` (
  `id` INTEGER NOT NULL AUTO_INCREMENT,
  `id_cultura` INTEGER NOT NULL,
  `nome` VARCHAR(50) NOT NULL,
  `data_inicio` DATE NULL,
  PRIMARY KEY (`id`)
) COMMENT 'Area (espaço) do cultivo de uma cultura';

-- ---
-- Table 'tb_sensores'
-- cadastro de sensores
-- ---

DROP TABLE IF EXISTS `tb_sensores`;
		
CREATE TABLE `tb_sensores` (
  `id` INTEGER NOT NULL AUTO_INCREMENT,
  `id_tipo_sensor` INTEGER NOT NULL,
  `codigo` VARCHAR(15) NOT NULL COMMENT 'codigo identificação do sensor/equipamento',
  PRIMARY KEY (`id`)
) COMMENT 'cadastro de sensores';

-- ---
-- Table 'tb_area_cultivo_sensores_instalado'
-- Cadastrar sensores instalados na area de cultivo
-- ---

DROP TABLE IF EXISTS `tb_area_cultivo_sensores_instalado`;
		
CREATE TABLE `tb_area_cultivo_sensores_instalado` (
  `id_sensor` INTEGER NOT NULL,
  `id_area_cultivo` INTEGER NOT NULL,
  PRIMARY KEY (`id_sensor`, `id_area_cultivo`)
) COMMENT 'Cadastrar sensores instalados na area de cultivo';

-- ---
-- Foreign Keys 
-- ---

ALTER TABLE `tb_coleta_sensores` ADD FOREIGN KEY (id_sensor) REFERENCES `tb_sensores` (`id`);
ALTER TABLE `tb_coleta_sensores` ADD FOREIGN KEY (id_area_cultivo) REFERENCES `tb_area_cultivo` (`id`);
ALTER TABLE `tb_agendamento_coleta` ADD FOREIGN KEY (id_tipo_sensor) REFERENCES `tb_tipo_sensores` (`id`);
ALTER TABLE `tb_sensores_unidades` ADD FOREIGN KEY (id_tipo_sensor) REFERENCES `tb_tipo_sensores` (`id`);
ALTER TABLE `tb_area_cultivo` ADD FOREIGN KEY (id_cultura) REFERENCES `tb_cultura` (`id`);
ALTER TABLE `tb_sensores` ADD FOREIGN KEY (id_tipo_sensor) REFERENCES `tb_tipo_sensores` (`id`);
ALTER TABLE `tb_area_cultivo_sensores_instalado` ADD FOREIGN KEY (id_sensor) REFERENCES `tb_sensores` (`id`);
ALTER TABLE `tb_area_cultivo_sensores_instalado` ADD FOREIGN KEY (id_area_cultivo) REFERENCES `tb_area_cultivo` (`id`);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `tb_tipo_sensores` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `tb_coleta_sensores` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `tb_agendamento_coleta` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `tb_sensores_unidades` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `tb_cultura` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `tb_area_cultivo` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `tb_sensores` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `tb_area_cultivo_sensores_instalado` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `tb_tipo_sensores` (`id`,`nome`,`descricao`) VALUES
-- ('','','');
-- INSERT INTO `tb_coleta_sensores` (`id`,`data`,`valor`,`id_sensor`,`id_area_cultivo`,`unidade`) VALUES
-- ('','','','','','');
-- INSERT INTO `tb_agendamento_coleta` (`id`,`descricao`,`express_cron`,`id_tipo_sensor`) VALUES
-- ('','','','');
-- INSERT INTO `tb_sensores_unidades` (`id`,`id_tipo_sensor`,`unidade`) VALUES
-- ('','','');
-- INSERT INTO `tb_cultura` (`id`,`nome`) VALUES
-- ('','');
-- INSERT INTO `tb_area_cultivo` (`id`,`id_cultura`,`nome`,`data_inicio`) VALUES
-- ('','','','');
-- INSERT INTO `tb_sensores` (`id`,`id_tipo_sensor`,`codigo`) VALUES
-- ('','','');
-- INSERT INTO `tb_area_cultivo_sensores_instalado` (`id_sensor`,`id_area_cultivo`) VALUES
-- ('','');