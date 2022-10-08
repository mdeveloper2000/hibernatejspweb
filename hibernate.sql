CREATE DATABASE hibernatedb;
USE hibernatedb;

CREATE TABLE estudantes (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    PRIMARY KEY(id),
    UNIQUE(nome)
);

CREATE TABLE cursos (
    id INT NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(20) NOT NULL,
    estudante_id INT DEFAULT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (estudante_id) REFERENCES estudantes(id)
);