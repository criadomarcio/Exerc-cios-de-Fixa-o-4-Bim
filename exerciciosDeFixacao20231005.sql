-- 1. Função para Contagem de Livros por Gênero
def total_livros_por_genero(genero):
    conn = conectar_banco_de_dados()
    cursor = conn.cursor()

  
    consulta = f"SELECT COUNT(*) FROM Livro WHERE genero = '{genero}'"

  
    cursor.execute(consulta)

   
    total = cursor.fetchone()[0]

    
    cursor.close()
    conn.close()

    return total

-- 2. Função para Listar Livros de um Autor Específico
def listar_livros_por_autor(primeiro_nome, ultimo_nome):
    
    conn = conectar_banco_de_dados()
    cursor = conn.cursor()

   
    consulta_autor = f"SELECT id_autor FROM Autor WHERE primeiro_nome = '{primeiro_nome}' AND ultimo_nome = '{ultimo_nome}'"

    
    cursor.execute(consulta_autor)

    
    id_autor = cursor.fetchone()

    if id_autor:
        
        consulta_livros = f"SELECT titulo FROM Livro_Autor WHERE id_autor = {id_autor[0]}"

      
        cursor.execute(consulta_livros)

       
        titulos = [livro[0] for livro in cursor.fetchall()]

        s
        cursor.close()
        conn.close()

        return titulos
    else:
        
        cursor.close()
        conn.close()
        return []

-- 3. Função para Atualizar Resumos de Livros
def atualizar_resumos():
    
    conn = conectar_banco_de_dados()
    cursor = conn.cursor()

    
    consulta = "UPDATE Livro SET resumo = CONCAT(resumo, ' Este é um excelente livro!')"

    
    cursor.execute(consulta)

    
    conn.commit()

   
    cursor.close()
    conn.close()
