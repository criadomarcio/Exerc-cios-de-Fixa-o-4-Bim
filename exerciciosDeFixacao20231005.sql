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

