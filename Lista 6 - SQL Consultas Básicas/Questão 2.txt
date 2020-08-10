insert into questionario values
(1,'tittle1','descricao1','24-09-2019','25-09-2019'),
(2,'tittle2','descricao2','20-09-2019','23-09-2019')

insert into questao values
(1,'enunciado1','objetiva'),
(2,'enunciado2','subjetiva'),
(3,'enunciado3','objetiva'),
(4,'enunciado4','objetiva'),
(5,'enunciado5','subjetiva'),
(6,'enunciado6','objetiva')

insert into questao_questionario values
(1, 1, 'obrigatória', 2.5),
(2, 1, 'não obrigatória', 3),
(3, 1, 'obrigatória', 4),
(4, 2, 'obrigatória', 4.5),
(5, 2, 'não obrigatória', 4),
(6, 2, 'obrigatória', 5)

insert into usuario values
(1,'A1009258','Apis@925'),
(2,'A1009257','Map*123'),
(3,'A1009256','Pacoca698'),
(4,'A1009255','Port%365'),
(5,'A1009254','Maca@123'),
(6,'A1009253','Sin@987'),
(7,'A1009252','Panela*42'),
(8,'A1009251','Feijao*'),
(9,'A1009250','TocToc423'),
(10,'A1009249','Parkur#')

insert into resp_questao_questionario values
(1, 3, 1),
(1, 1, 2),
(10, 5, 2),
(1, 3, 2),
(2, 3, 1),
(3, 1, 2),
(1, 2, 2),
(5, 3, 1),
(1, 6, 1),
(7, 6, 2),
(1, 2, 1),
(9, 5, 2),
(1, 5, 1)
