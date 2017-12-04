-- MySQL Script generated by MySQL Workbench
-- Mon Dec  4 16:17:39 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema admon
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema admon
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `admon` DEFAULT CHARACTER SET utf8 ;
USE `admon` ;

-- -----------------------------------------------------
-- Table `admon`.`depositarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`depositarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `apellido_paterno` VARCHAR(45) NULL,
  `apellido_materno` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `admon`.`estados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`estados` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `admon`.`municipios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`municipios` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `estados_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_municipios_estados_1`
    FOREIGN KEY (`estados_id`)
    REFERENCES `admon`.`estados` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_municipios_estados_idx` ON `admon`.`municipios` (`estados_id` ASC);


-- -----------------------------------------------------
-- Table `admon`.`domicilios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`domicilios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cp` INT NOT NULL,
  `int` VARCHAR(45) NULL,
  `ext` VARCHAR(45) NULL,
  `calle` VARCHAR(45) NOT NULL,
  `colonia` CHAR(50) NOT NULL,
  `estados_id` INT NOT NULL,
  `municipios_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_domicilios_estados`
    FOREIGN KEY (`estados_id`)
    REFERENCES `admon`.`estados` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_domicilios_municipios`
    FOREIGN KEY (`municipios_id`)
    REFERENCES `admon`.`municipios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_domicilios_estados_idx` ON `admon`.`domicilios` (`estados_id` ASC);

CREATE INDEX `fk_domicilios_municipios_idx` ON `admon`.`domicilios` (`municipios_id` ASC);


-- -----------------------------------------------------
-- Table `admon`.`bienes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`bienes` (
  `numero_control` INT NOT NULL,
  `depositarios_id` INT NOT NULL,
  `deposito_id` INT NOT NULL,
  PRIMARY KEY (`numero_control`),
  CONSTRAINT `fk_bienes_depositarios`
    FOREIGN KEY (`depositarios_id`)
    REFERENCES `admon`.`depositarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bienes_domicilios`
    FOREIGN KEY (`deposito_id`)
    REFERENCES `admon`.`domicilios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_bienes_depositarios_idx` ON `admon`.`bienes` (`depositarios_id` ASC);

CREATE INDEX `fk_bienes_domicilios_idx` ON `admon`.`bienes` (`deposito_id` ASC);


-- -----------------------------------------------------
-- Table `admon`.`contribuyentes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`contribuyentes` (
  `id` VARCHAR(45) CHARACTER SET 'big5' NULL COMMENT 'Este es el CURP o el RFC',
  `razon_social` VARCHAR(45) NULL,
  `nombre` VARCHAR(45) NULL,
  `apellido_paterno` VARCHAR(45) NULL,
  `apellido_materno` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `rfc` VARCHAR(45) NULL COMMENT 'En caso de que cuente con CURP y RFC',
  `estado` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `rfc_UNIQUE` ON `admon`.`contribuyentes` (`rfc` ASC);


-- -----------------------------------------------------
-- Table `admon`.`creditos_fiscales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`creditos_fiscales` (
  `folio` CHAR(50) NOT NULL,
  `monto` DOUBLE(15,8) NOT NULL,
  `documento_determinante` CHAR(50) NOT NULL,
  `origen_credito` CHAR(50) NOT NULL,
  `estatus` TINYINT NULL DEFAULT 1,
  `contribuyentes_id` VARCHAR(45) CHARACTER SET 'big5' NOT NULL,
  PRIMARY KEY (`folio`),
  CONSTRAINT `fk_creditos_fiscales_contribuyentes`
    FOREIGN KEY (`contribuyentes_id`)
    REFERENCES `admon`.`contribuyentes` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_creditos_fiscales_contribuyentes1_idx` ON `admon`.`creditos_fiscales` (`contribuyentes_id` ASC);


-- -----------------------------------------------------
-- Table `admon`.`Deudor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`Deudor` (
  `Nombre` INT NOT NULL,
  PRIMARY KEY (`Nombre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `admon`.`peritos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`peritos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `apellido_paterno` VARCHAR(45) NULL,
  `apellido_materno` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `admon`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`categorias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `admon`.`subcategorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`subcategorias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `admon`.`articulos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`articulos` (
  `id` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(255) NULL,
  `estado` TINYINT(1) NULL DEFAULT 1,
  `cantidad` INT(10) NULL,
  `bienes_numero_control` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_articulos_bienes1`
    FOREIGN KEY (`bienes_numero_control`)
    REFERENCES `admon`.`bienes` (`numero_control`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_articulos_bienes1_idx` ON `admon`.`articulos` (`bienes_numero_control` ASC);


-- -----------------------------------------------------
-- Table `admon`.`imagenes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`imagenes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(255) NULL,
  `articulos_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_imagenes_articulos1`
    FOREIGN KEY (`articulos_id`)
    REFERENCES `admon`.`articulos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `admon`.`imagenes` (`nombre` ASC);

CREATE INDEX `fk_imagenes_articulos1_idx` ON `admon`.`imagenes` (`articulos_id` ASC);


-- -----------------------------------------------------
-- Table `admon`.`categorias_subcategorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`categorias_subcategorias` (
  `categorias_id` INT NOT NULL,
  `subcategorias_id` INT NOT NULL,
  PRIMARY KEY (`categorias_id`, `subcategorias_id`),
  CONSTRAINT `fk_bienes_has_categorias_categorias1`
    FOREIGN KEY (`categorias_id`)
    REFERENCES `admon`.`categorias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_categorias_subcategorias_subcategorias1`
    FOREIGN KEY (`subcategorias_id`)
    REFERENCES `admon`.`subcategorias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_bienes_has_categorias_categorias1_idx` ON `admon`.`categorias_subcategorias` (`categorias_id` ASC);

CREATE INDEX `fk_categorias_subcategorias_subcategorias1_idx` ON `admon`.`categorias_subcategorias` (`subcategorias_id` ASC);


-- -----------------------------------------------------
-- Table `admon`.`permisos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`permisos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `admon`.`rols`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`rols` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `admon`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `apellido_paterno` VARCHAR(45) NULL,
  `apellido_materno` VARCHAR(45) NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `estado` TINYINT NULL DEFAULT 1,
  `remember_token` VARCHAR(255) NULL,
  `rols_id` INT NOT NULL DEFAULT 2,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_users_rols1`
    FOREIGN KEY (`rols_id`)
    REFERENCES `admon`.`rols` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `correo_UNIQUE` ON `admon`.`users` (`email` ASC);

CREATE INDEX `fk_users_rols1_idx` ON `admon`.`users` (`rols_id` ASC);


-- -----------------------------------------------------
-- Table `admon`.`motivos_bajas_creditos_fiscales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`motivos_bajas_creditos_fiscales` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `admon`.`bajas_creditos_fiscales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`bajas_creditos_fiscales` (
  `baja` INT NOT NULL,
  `usuarios_id` INT NOT NULL,
  `comentarios` VARCHAR(255) NOT NULL,
  `creditos_fiscales_folio` CHAR(15) NOT NULL,
  PRIMARY KEY (`baja`, `usuarios_id`),
  CONSTRAINT `fk_creditos_fiscales_has_motivos_bajas_creditos_fiscales_moti1`
    FOREIGN KEY (`baja`)
    REFERENCES `admon`.`motivos_bajas_creditos_fiscales` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_altas_bajas_creditos_fiscales_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `admon`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bajas_creditos_fiscales_creditos_fiscales1`
    FOREIGN KEY (`creditos_fiscales_folio`)
    REFERENCES `admon`.`creditos_fiscales` (`folio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_creditos_fiscales_has_motivos_bajas_creditos_fiscales_mo_idx` ON `admon`.`bajas_creditos_fiscales` (`baja` ASC);

CREATE INDEX `fk_altas_bajas_creditos_fiscales_usuarios1_idx` ON `admon`.`bajas_creditos_fiscales` (`usuarios_id` ASC);

CREATE INDEX `fk_bajas_creditos_fiscales_creditos_fiscales1_idx` ON `admon`.`bajas_creditos_fiscales` (`creditos_fiscales_folio` ASC);


-- -----------------------------------------------------
-- Table `admon`.`direcciones_contribuyentes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`direcciones_contribuyentes` (
  `domicilios_id` INT NOT NULL,
  `contribuyentes_id` VARCHAR(45) CHARACTER SET 'big5' NOT NULL,
  PRIMARY KEY (`domicilios_id`),
  CONSTRAINT `fk_contribuyentes_has_domicilios_domicilios`
    FOREIGN KEY (`domicilios_id`)
    REFERENCES `admon`.`domicilios` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_direcciones_contribuyentes_fisicos_contribuyentes`
    FOREIGN KEY (`contribuyentes_id`)
    REFERENCES `admon`.`contribuyentes` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_contribuyentes_has_domicilios_domicilios1_idx` ON `admon`.`direcciones_contribuyentes` (`domicilios_id` ASC);

CREATE INDEX `fk_direcciones_contribuyentes_fisicos_contribuyentes1_idx` ON `admon`.`direcciones_contribuyentes` (`contribuyentes_id` ASC);


-- -----------------------------------------------------
-- Table `admon`.`permisos_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`permisos_usuarios` (
  `usuarios_id` INT NOT NULL,
  `permisos_id` INT NOT NULL,
  CONSTRAINT `fk_usuarios_has_permisos_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `admon`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_has_permisos_permisos1`
    FOREIGN KEY (`permisos_id`)
    REFERENCES `admon`.`permisos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_usuarios_has_permisos_permisos1_idx` ON `admon`.`permisos_usuarios` (`permisos_id` ASC);

CREATE INDEX `fk_usuarios_has_permisos_usuarios1_idx` ON `admon`.`permisos_usuarios` (`usuarios_id` ASC);


-- -----------------------------------------------------
-- Table `admon`.`embargos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`embargos` (
  `Creditos_Fiscales_folio` CHAR(50) NOT NULL,
  `bienes_numero_control` INT NOT NULL,
  `documento` VARCHAR(45) NULL,
  `fecha` VARCHAR(45) NULL,
  CONSTRAINT `fk_Creditos_Fiscales_has_bienes_Creditos_Fiscales1`
    FOREIGN KEY (`Creditos_Fiscales_folio`)
    REFERENCES `admon`.`creditos_fiscales` (`folio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Creditos_Fiscales_has_bienes_bienes1`
    FOREIGN KEY (`bienes_numero_control`)
    REFERENCES `admon`.`bienes` (`numero_control`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Creditos_Fiscales_has_bienes_bienes1_idx` ON `admon`.`embargos` (`bienes_numero_control` ASC);

CREATE INDEX `fk_Creditos_Fiscales_has_bienes_Creditos_Fiscales1_idx` ON `admon`.`embargos` (`Creditos_Fiscales_folio` ASC);


-- -----------------------------------------------------
-- Table `admon`.`articulos_categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`articulos_categorias` (
  `articulos_id` VARCHAR(45) NOT NULL,
  `categorias_id` INT NOT NULL,
  `subcategoria_id` INT NULL DEFAULT NULL,
  `subsubcategoria_id` INT NULL DEFAULT NULL,
  CONSTRAINT `fk_articulos_has_categorias_categorias1`
    FOREIGN KEY (`categorias_id`)
    REFERENCES `admon`.`categorias` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_articulos_categorias_articulos1`
    FOREIGN KEY (`articulos_id`)
    REFERENCES `admon`.`articulos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_articulos_has_categorias_categorias1_idx` ON `admon`.`articulos_categorias` (`categorias_id` ASC);

CREATE INDEX `fk_articulos_categorias_articulos1_idx` ON `admon`.`articulos_categorias` (`articulos_id` ASC);


-- -----------------------------------------------------
-- Table `admon`.`valuaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`valuaciones` (
  `peritos_id` INT NOT NULL,
  `monto` FLOAT NOT NULL,
  `fecha` DATE NOT NULL,
  `numero_dictamen` CHAR(255) NOT NULL,
  `articulos_id` VARCHAR(45) NOT NULL,
  CONSTRAINT `fk_valuaciones_peritos`
    FOREIGN KEY (`peritos_id`)
    REFERENCES `admon`.`peritos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_valuaciones_articulos1`
    FOREIGN KEY (`articulos_id`)
    REFERENCES `admon`.`articulos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_articulos_has_peritos_peritos1_idx` ON `admon`.`valuaciones` (`peritos_id` ASC);

CREATE INDEX `fk_valuaciones_articulos1_idx` ON `admon`.`valuaciones` (`articulos_id` ASC);


-- -----------------------------------------------------
-- Table `admon`.`postores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`postores` (
  `RFC` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido_paterno` VARCHAR(45) NULL,
  `apellido_materno` VARCHAR(45) NULL,
  `correo` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `domicilios_id` INT NOT NULL,
  PRIMARY KEY (`RFC`),
  CONSTRAINT `fk_postores_domicilios1`
    FOREIGN KEY (`domicilios_id`)
    REFERENCES `admon`.`domicilios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_postores_domicilios1_idx` ON `admon`.`postores` (`domicilios_id` ASC);


-- -----------------------------------------------------
-- Table `admon`.`remates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`remates` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha_inicio` DATE NOT NULL,
  `fecha_fin` DATE NOT NULL,
  `estado` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_UNIQUE` ON `admon`.`remates` (`id` ASC);


-- -----------------------------------------------------
-- Table `admon`.`pujas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`pujas` (
  `postores_RFC` INT NOT NULL,
  `remate_id` INT NOT NULL,
  `oferta` FLOAT NOT NULL,
  CONSTRAINT `fk_pujas_postores`
    FOREIGN KEY (`postores_RFC`)
    REFERENCES `admon`.`postores` (`RFC`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pujas_remate1`
    FOREIGN KEY (`remate_id`)
    REFERENCES `admon`.`remates` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Pujas_postores1_idx` ON `admon`.`pujas` (`postores_RFC` ASC);

CREATE INDEX `fk_pujas_remate1_idx` ON `admon`.`pujas` (`remate_id` ASC);


-- -----------------------------------------------------
-- Table `admon`.`subsubcategorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`subsubcategorias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `admon`.`motivos_bajas_articulos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`motivos_bajas_articulos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `admon`.`bajas_articulos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`bajas_articulos` (
  `motivos_bajas_articulos_id` INT NOT NULL,
  `usuarios_id` INT NOT NULL,
  `comentarios` VARCHAR(255) NULL,
  `articulos_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`articulos_id`),
  CONSTRAINT `fk_articulos_has_motivos_bajas_articulos_motivos_bajas_articu1`
    FOREIGN KEY (`motivos_bajas_articulos_id`)
    REFERENCES `admon`.`motivos_bajas_articulos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bajas_articulos_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `admon`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_bajas_articulos_articulos1`
    FOREIGN KEY (`articulos_id`)
    REFERENCES `admon`.`articulos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_articulos_has_motivos_bajas_articulos_motivos_bajas_arti_idx` ON `admon`.`bajas_articulos` (`motivos_bajas_articulos_id` ASC);

CREATE INDEX `fk_bajas_articulos_usuarios1_idx` ON `admon`.`bajas_articulos` (`usuarios_id` ASC);


-- -----------------------------------------------------
-- Table `admon`.`lotes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`lotes` (
  `remate_id` INT NOT NULL,
  `articulos_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`remate_id`),
  CONSTRAINT `fk_remate`
    FOREIGN KEY (`remate_id`)
    REFERENCES `admon`.`remates` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_lotes_articulos1`
    FOREIGN KEY (`articulos_id`)
    REFERENCES `admon`.`articulos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_lotes_remate1_idx` ON `admon`.`lotes` (`remate_id` ASC);

CREATE INDEX `fk_lotes_articulos1_idx` ON `admon`.`lotes` (`articulos_id` ASC);


-- -----------------------------------------------------
-- Table `admon`.`subcategorias_subsubcategorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`subcategorias_subsubcategorias` (
  `subcategorias_id` INT NOT NULL,
  `subsubcategorias_id` INT NOT NULL,
  PRIMARY KEY (`subcategorias_id`, `subsubcategorias_id`),
  CONSTRAINT `fk_subcategorias_has_subsubcategorias_subcategorias1`
    FOREIGN KEY (`subcategorias_id`)
    REFERENCES `admon`.`subcategorias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subcategorias_has_subsubcategorias_subsubcategorias1`
    FOREIGN KEY (`subsubcategorias_id`)
    REFERENCES `admon`.`subsubcategorias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_subcategorias_has_subsubcategorias_subsubcategorias1_idx` ON `admon`.`subcategorias_subsubcategorias` (`subsubcategorias_id` ASC);

CREATE INDEX `fk_subcategorias_has_subsubcategorias_subcategorias1_idx` ON `admon`.`subcategorias_subsubcategorias` (`subcategorias_id` ASC);

USE `admon` ;

-- -----------------------------------------------------
-- Placeholder table for view `admon`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admon`.`view1` (`id` INT);

-- -----------------------------------------------------
-- View `admon`.`view1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `admon`.`view1`;
USE `admon`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
