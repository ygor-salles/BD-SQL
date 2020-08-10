select q.titulo, count(qq.codQuestao)
from questionario q, questao_questionario qq
where q.codigo = qq.codQuestionario
group by (q.titulo) 

select u.login, count(uqq.codQuestionario)
from usuario u, usu_questao_questionario uqq, questao q, questionario qt
where uqq.codUsuario = u.codigo and uqq.codQuestao = q.codigo and uqq.codQuestionario = qt.codigo
group by (u.login)

select qt.titulo, q.enunciado
from questionario qt, questao q, questao_questionario qq
where qq.codQuestao = q.codigo and qq.codQuestionario = qt.codigo and qt.data_criacao > '20-09-2019'
group by (qt.titulo, q.enunciado)

select u.login, e.e_mail, qt.titulo, q.enunciado, rqq.resposta
from usuario u, e_mail e, questionario qt, questao q, resp_questao_questionario rqq, respondente r
where rqq.codResp = r.codUsuario and rqq.codQuestao = q.codigo and rqq.codQuestionario = q.codigo
group by (rqq.resposta)