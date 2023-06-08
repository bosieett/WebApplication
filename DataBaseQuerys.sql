CREATE DATABASE pw_pia_db;
use pw_pia_db;
CREATE TABLE estatus (
 idestatus BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 estatus VARCHAR(15)
);
insert into estatus(estatus) values('Activo');
insert into estatus(estatus) values('Inactivo');
CREATE TABLE categoria (
 idcat BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 categoria VARCHAR(30)
);
insert into categoria(categoria) values('CAFÉ');
insert into categoria(categoria) values('TÉ');
insert into categoria(categoria) values('MATCHA');
insert into categoria(categoria) values('CAFÉ HELADO');
insert into categoria(categoria) values('LATTE');
insert into categoria(categoria) values('DESAYUNO');
insert into categoria(categoria) values('CITA');
insert into categoria(categoria) values('AESTHETIC');
CREATE TABLE usuario (
 iduser BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 nombre VARCHAR(36) NOT NULL,
 appaterno VARCHAR(25) NOT NULL,
 apmaterno VARCHAR(25) NOT NULL,
 fechanac DATE NOT NULL,
 email VARCHAR(100) UNIQUE NOT NULL,
 imagen VARCHAR(250),
 nusuario VARCHAR(25) UNIQUE NOT NULL,
 contrasenia VARCHAR(25) NOT NULL,
 fechacrea DATE
);
CREATE TABLE publicacion(
 idpubli BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 titulo VARCHAR(50) NOT NULL,
 texto VARCHAR(250) NOT NULL,
 fechapubli DATE,
 imagen VARCHAR(250),
 estatusid BIGINT UNSIGNED,
 userid BIGINT UNSIGNED,
 catid BIGINT UNSIGNED,
 FOREIGN KEY (estatusid)
 REFERENCES estatus(idestatus),
 FOREIGN KEY (userid)
 REFERENCES usuario(iduser),
 FOREIGN KEY (catid)
 REFERENCES categoria(idcat)
);
use pw_pia_db;
delimiter //
CREATE PROCEDURE sp_publicacion (
    IN p_opcion varchar(1),
    IN p_idpubli bigint,
    IN p_titulo varchar(50),
    IN p_texto varchar(250),
    IN p_imagen varchar(250),
    IN p_userid bigint,
    IN p_catid bigint
)
BEGIN
    CASE p_opcion
        WHEN 'i' THEN
            INSERT INTO publicacion (
                titulo, texto, imagen, userid, catid, estatusid, fechapubli
            ) VALUES (
                p_titulo, p_texto, p_imagen, p_userid, p_catid, 1, curdate()
            );
        WHEN 'd' THEN
            UPDATE publicacion SET estatusid = 2 WHERE idpubli = p_idpubli;
		WHEN 's' THEN
			SELECT publicacion.idpubli, publicacion.titulo, publicacion.texto,
            publicacion.fechapubli, publicacion.imagen, publicacion.estatusid,
            usuario.nusuario, categoria.categoria
            FROM publicacion INNER JOIN categoria ON categoria.idcat=publicacion.catid
            INNER JOIN usuario ON usuario.iduser=publicacion.userid  WHERE publicacion.estatusid=1 ORDER BY publicacion.fechapubli DESC;
		WHEN 'u' THEN
			SELECT publicacion.idpubli, publicacion.titulo, publicacion.texto,
            publicacion.fechapubli, publicacion.imagen, publicacion.estatusid,
            usuario.nusuario, categoria.categoria
            FROM publicacion INNER JOIN categoria ON categoria.idcat=publicacion.catid
            INNER JOIN usuario ON usuario.iduser=publicacion.userid  WHERE publicacion.estatusid=1 AND usuario.iduser=p_userid ORDER BY publicacion.fechapubli DESC;
		WHEN 'g' THEN
			SELECT publicacion.idpubli, publicacion.titulo, publicacion.texto,
            publicacion.fechapubli, publicacion.imagen, publicacion.estatusid,
            usuario.nusuario, categoria.categoria
            FROM publicacion INNER JOIN categoria ON categoria.idcat=publicacion.catid
            INNER JOIN usuario ON usuario.iduser=publicacion.userid  WHERE publicacion.idpubli=p_idpubli;
		WHEN 'e' THEN
			UPDATE publicacion SET titulo=p_titulo, texto=p_texto, imagen=p_imagen WHERE idpubli=p_idpubli;
		WHEN 'c' THEN
			SELECT publicacion.idpubli, publicacion.titulo, publicacion.texto,
            publicacion.fechapubli, publicacion.imagen, publicacion.estatusid,
            usuario.nusuario, categoria.categoria
            FROM publicacion INNER JOIN categoria ON categoria.idcat=publicacion.catid
            INNER JOIN usuario ON usuario.iduser=publicacion.userid  WHERE publicacion.estatusid=1 AND publicacion.catid=p_catid ORDER BY publicacion.fechapubli DESC;
		WHEN 'b' THEN
			SELECT publicacion.idpubli, publicacion.titulo, publicacion.texto,
            publicacion.fechapubli, publicacion.imagen, publicacion.estatusid,
            usuario.nusuario, categoria.categoria
            FROM publicacion INNER JOIN categoria ON categoria.idcat=publicacion.catid
            INNER JOIN usuario ON usuario.iduser=publicacion.userid  WHERE publicacion.estatusid=1 AND (publicacion.texto LIKE CONCAT('%',p_texto,'%') OR publicacion.titulo LIKE CONCAT('%', p_texto,'%')) ORDER BY publicacion.fechapubli DESC;
   END CASE;
END//
delimiter //
create procedure sp_advancedsearch(IN p_titulo varchar(50),
    IN p_texto varchar(250), IN p_categoria bigint, IN p_fechain date, IN p_fechafin date)
begin
	IF(p_fechain IS NULL AND p_fechafin IS NOT NULL) THEN
	SELECT publicacion.idpubli, publicacion.titulo, publicacion.texto,
            publicacion.fechapubli, publicacion.imagen, publicacion.estatusid,
            usuario.nusuario, categoria.categoria
            FROM publicacion INNER JOIN categoria ON categoria.idcat=publicacion.catid
            INNER JOIN usuario ON usuario.iduser=publicacion.userid  WHERE publicacion.estatusid=1 AND (publicacion.texto LIKE CONCAT('%',IFNULL(p_texto,publicacion.texto),'%') OR publicacion.titulo LIKE CONCAT('%', IFNULL(p_texto,publicacion.titulo),'%')) AND publicacion.fechapubli<=p_fechafin AND publicacion.catid=ifnull(p_categoria, publicacion.catid) ORDER BY publicacion.fechapubli DESC;
            END IF;
            IF(p_fechafin IS NULL AND p_fechain IS NOT NULL) THEN
	SELECT publicacion.idpubli, publicacion.titulo, publicacion.texto,
            publicacion.fechapubli, publicacion.imagen, publicacion.estatusid,
            usuario.nusuario, categoria.categoria
            FROM publicacion INNER JOIN categoria ON categoria.idcat=publicacion.catid
            INNER JOIN usuario ON usuario.iduser=publicacion.userid  WHERE publicacion.estatusid=1 AND (publicacion.texto LIKE CONCAT('%',IFNULL(p_texto,publicacion.texto),'%') OR publicacion.titulo LIKE CONCAT('%', IFNULL(p_texto,publicacion.titulo),'%')) AND publicacion.fechapubli>=p_fechain AND publicacion.catid=ifnull(p_categoria, publicacion.catid) ORDER BY publicacion.fechapubli DESC;
            END IF;
            IF(p_fechain IS NULL AND p_fechafin is NULL) THEN
	SELECT publicacion.idpubli, publicacion.titulo, publicacion.texto,
            publicacion.fechapubli, publicacion.imagen, publicacion.estatusid,
            usuario.nusuario, categoria.categoria
            FROM publicacion INNER JOIN categoria ON categoria.idcat=publicacion.catid
            INNER JOIN usuario ON usuario.iduser=publicacion.userid  WHERE publicacion.estatusid=1 AND (publicacion.texto LIKE CONCAT('%',IFNULL(p_texto,publicacion.texto),'%') OR publicacion.titulo LIKE CONCAT('%', IFNULL(p_texto,publicacion.titulo),'%')) AND publicacion.catid=ifnull(p_categoria, publicacion.catid) ORDER BY publicacion.fechapubli DESC;
            END IF;
            IF(p_fechain IS NOT NULL AND p_fechafin IS NOT NULL) THEN
	SELECT publicacion.idpubli, publicacion.titulo, publicacion.texto,
            publicacion.fechapubli, publicacion.imagen, publicacion.estatusid,
            usuario.nusuario, categoria.categoria
            FROM publicacion INNER JOIN categoria ON categoria.idcat=publicacion.catid
            INNER JOIN usuario ON usuario.iduser=publicacion.userid  WHERE publicacion.estatusid=1 AND (publicacion.texto LIKE CONCAT('%',IFNULL(p_texto,publicacion.texto),'%') OR publicacion.titulo LIKE CONCAT('%', IFNULL(p_texto,publicacion.titulo),'%')) AND publicacion.fechapubli>=p_fechain AND publicacion.fechapubli<=p_fechafin AND publicacion.catid=ifnull(p_categoria, publicacion.catid) ORDER BY publicacion.fechapubli DESC;
		end if;
END//
delimiter //
create procedure sp_usuario(IN u_opcion varchar(1),
	in u_iduser BIGINT,
	in u_nombre VARCHAR(36),
    in u_appaterno VARCHAR(25),
    in u_apmaterno VARCHAR (25),
	in u_fechanac DATE,
    in u_email VARCHAR(100),
    in u_imagen VARCHAR(250),
    in u_nusuario VARCHAR(25),
    in u_contrasenia VARCHAR(25)
)
begin
	case u_opcion
    when 'r' then
		insert into usuario(nombre,appaterno, apmaterno,fechanac,email,imagen,nusuario,contrasenia,fechacrea)
        VALUES(u_nombre, u_appaterno, u_apmaterno, u_fechanac, u_email, u_imagen, u_nusuario, u_contrasenia,curdate());
	when 'l' then
		Select iduser, nombre, appaterno, apmaterno,fechanac,email,imagen,nusuario,contrasenia,fechacrea from usuario where BINARY nusuario = u_nusuario AND BINARY contrasenia = u_contrasenia;
	when 'v' then
		Select iduser, nombre, appaterno, apmaterno,fechanac,email,imagen,nusuario,contrasenia,fechacrea from usuario where nusuario = u_nusuario;
	when 'b' then
		select iduser, nombre, appaterno, apmaterno,fechanac,email,imagen,nusuario,contrasenia,fechacrea from usuario where email=u_email;
	when 'u' then
		update usuario set nombre=u_nombre, appaterno=u_appaterno,
        apmaterno=u_apmaterno, fechanac=u_fechanac, email=u_email,
        imagen=u_imagen, contrasenia=u_contrasenia where nusuario=u_nusuario;
    end case;
end//