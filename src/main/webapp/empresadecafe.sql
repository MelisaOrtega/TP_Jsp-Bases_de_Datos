CREATE DATABASE empresadecafe
/********************************TABLAS***********************************/
CREATE TABLE tb_prod (
    id_prod int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom_prod varchar(45),
    desc_prod varchar(60),
    costo int(4))
;

CREATE TABLE tb_sucur (
    id_sucur int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    nom_sucur varchar(45),
    direc varchar (45))
;

CREATE TABLE tb_prod_sucur (
    id_tbprod int NOT NULL, 
    id_tbsucur int NOT NULL,
    stock int (5),
    PRIMARY KEY(id_tbprod, id_tbsucur),
    FOREIGN KEY(id_tbprod) REFERENCES tb_prod(id_prod) ,
    FOREIGN KEY(id_tbsucur) REFERENCES tb_sucur(id_sucur) 
);
ON DELETE CASCADE
ON DELETE CASCADE
/*******************************INSERTS**************************************/
INSERT INTO tb_prod (nom_prod, desc_prod, costo) 
VALUES ('Aglomerado' , 'Intenso y con cuerpo.', 3800), 
       ('Liofilizado','Balanceado y aromático.', 4000), 
       ('Liofilizado Micronizado','Con un toque de café tostado micromolido.',2300), 
       ('Espresso','Espuma delicada en la taza.',4800),),
       ('Cereales','Con o sin café y leche.',1280)
       ('Capuchinos','Clásico y aromatizado.',1280
;


insert into tb_sucur(id_sucur, nom_sucur, direc)
values (1,'Nueva Pompeya', 'Av.Saenz 1452'),
       (2,'Liniers','Av.Emilio Castro 5804 '),
       (3, 'Floresta','Av.Juan B.Justo 6497')
;

INSERT INTO tb_prod_sucur (id_tbprod, id_tbsucur, stock)
VALUES (1,1,700),(2,1,500),(3,1,100),(1,2,200),(2,2,50),(3,2,300),(1,3,400),(2,3,80),(3,3,150),(5,1,480),(5,2,10);
 
/********************************CONSULTAS************************************/
 
SELECT tb_prod.nom_prod AS producto,
       tb_prod.desc_prod AS descripcion,
       tb_prod.costo AS precio, 
       tb_prod_sucur.stock As stock,
       tb_sucur.nom_sucur AS sucursal, 
       tb_sucur.direc AS ubicacion 
FROM tb_prod_sucur
    JOIN tb_prod 
        ON tb_prod_sucur.id_tbprod= tb_prod.id_prod 
    JOIN tb_sucur
        ON tb_prod_sucur.id_tbsucur= tb_sucur.id_sucur
    AND tb_sucur.id_sucur=1;

/*******************************************UPDATES***************************************************/

UPDATE tb_prod SET costo=? WHERE nom_prod=?;
UPDATE tb_prod_sucur SET stock= ? WHERE id_prod= ?;
UPDATE tb_prod_sucur SET costo= ? WHERE id_prod= ?;

/***************************Carga elimina stock*****************************/


DELETE FROM tb_prod_sucur WHERE id_tbprod=? AND id_tbsucur=?;

/**********************************************************************/
 SET @id_prod= LAST_INSERT_ID();

INSERT INTO tb_prod_sucur ( id_tbsucur, id_tbprod) VALUES (2,@id_prod);
INSERT INTO tb_prod_sucur ( id_tbsucur, id_tbprod,stock) VALUES (2,@id_prod,1);

