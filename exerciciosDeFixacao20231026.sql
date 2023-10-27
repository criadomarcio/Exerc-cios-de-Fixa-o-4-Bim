CREATE DATABASE exercicios_trigger;
USE exercicios_trigger;

-- 1
CREATE TRIGGER insert_cliente_auditoria
AFTER INSERTING ON Clients
FOR EACH ROW
INSERT INTO Auditoria (mensagem) VALUES (CONCAT('Novo cliente inserido em', NOW()));

-- 2
CREATE TRIGGER tentativa_exclusao_clientes_auditoria
BEFORE DELETE ON Clientes
FOR EACH ROW
INSERT INTO Auditoria (mensagem) VALUES (CONCAT('Tentativa de exclusão de cliente em', NOW()));

-- 3
CREATE TRIGGER atualiza_nome_cliente_auditoria
AFTER UPDATE ON Clientes
FOR EACH ROW
INSERT INTO Auditoria (mensagem) VALUES (CONCAT('Nome antigo: ', OLD.nome, 'Novo nome: ', NEW.nome));

-- 4
CREATE TRIGGER impede_nome_vazio_null
BEFORE UPDATE ON Clientes
FOR EACH ROW
BEGIN
  IF NEW.nome IS NULL OR NEW.nome = '' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Nome não pode ser vazio ou NULL';
  END IF;
END;

-- 5
CREATE TRIGGER atualiza_estoque_pedido_auditoria
AFTER INSERT ON Pedidos
FOR EACH ROW
BEGIN
  UPDATE Produtos
  SET estoque = estoque - 1
  WHERE id = NEW.produto_id;

  IF (SELECT estoque FROM Produtos WHERE id = NEW.produto_id) <5 THEN
    INSERT INTO Auditoria (mensagem) VALUES (CONCAT('Estoque baixo para o produto', NEW.produto_id, 'em' NOW()));
  END IF;
END;
